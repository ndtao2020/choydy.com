package org.acme.controller;

import com.fasterxml.jackson.databind.JsonNode;
import io.quarkus.elytron.security.common.BcryptUtil;
import io.quarkus.mailer.Mail;
import io.quarkus.mailer.Mailer;
import io.quarkus.security.UnauthorizedException;
import org.acme.HomeRoute;
import org.acme.RequestFilter;
import org.acme.base.auth.ClientPrincipal;
import org.acme.base.dto.CheckDTO;
import org.acme.base.dto.CredentialDTO;
import org.acme.base.dto.GoogleDTO;
import org.acme.base.dto.JwtToken;
import org.acme.base.dto.LoginDTO;
import org.acme.base.dto.RegisterDTO;
import org.acme.base.dto.ResetPassword;
import org.acme.base.dto.SocialLoginDTO;
import org.acme.base.dto.TokenDTO;
import org.acme.base.jwt.JwtUtil;
import org.acme.constants.SecurityPath;
import org.acme.constants.Social;
import org.acme.model.User;
import org.acme.model.dto.UserDTO;
import org.acme.rest.GoogleService;
import org.acme.service.UserAuthorityService;
import org.acme.service.UserService;
import org.acme.service.UserSocialNetworkService;
import org.acme.utils.RandomUtil;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.jboss.logging.Logger;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.validation.constraints.Email;
import javax.ws.rs.BadRequestException;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

@Path(SecurityPath.OAUTH_API_URL)
public class OAuthController {

    private static final Logger logger = Logger.getLogger(OAuthController.class);

    @Inject
    JwtUtil jwtUtil;
    @Inject
    UserService userService;
    @Inject
    UserAuthorityService userAuthorityService;
    @Inject
    UserSocialNetworkService userSocialNetworkService;
    @Inject
    Mailer mailer;
    @Inject
    @RestClient
    GoogleService googleService;

    @POST
    @Path("/login")
    public Response login(@Context SecurityContext context, LoginDTO loginDTO) throws SQLException {
        if (loginDTO.getUsername() == null || loginDTO.getPassword() == null) {
            throw new BadRequestException("Username and Password can not be empty !");
        }
        User user = userService.loadUserByUsername(loginDTO.getUsername());
        if (user == null || !BcryptUtil.matches(loginDTO.getPassword(), user.getPassword())) {
            throw new UnauthorizedException("User is not exist !");
        }
        return validate(context, user);
    }

    @POST
    @Path("/social")
    public Response loginBySocial(@Context SecurityContext context, @Valid SocialLoginDTO loginDTO) throws UnauthorizedException, BadRequestException, SQLException, NoSuchAlgorithmException {
        if (loginDTO.getSocial() == null || loginDTO.getEmail() == null || loginDTO.getCredential() == null) {
            throw new BadRequestException("Email and Access Token can not be empty !");
        }
        CredentialDTO credentialDTO = loginDTO.getCredential();
        if (loginDTO.getSocial().equals(Social.GOOGLE)) {
            GoogleDTO googleDTO = googleService.checkGoogleToken(credentialDTO.getIdToken());
            if (googleDTO == null) {
                throw new BadRequestException("Không thể xác thực với Google !");
            }
            logger.info("Logged: " + googleDTO.email);
            if (!loginDTO.getEmail().equals(googleDTO.email)) {
                throw new BadRequestException("Không thể xác thực với Google ! wrong email !");
            }
        }
        User user = null;
        try {
            logger.info("Đã load vào loadUserByUsername " + loginDTO.getEmail());
            user = userService.loadUserByUsername(loginDTO.getEmail());
            logger.info("Đã load xong loadUserByUsername " + loginDTO.getEmail());
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        if (user == null) {
            logger.info("Đã load vào validate " + loginDTO.getEmail());
            return validate(context, createUser(loginDTO));
        }
        logger.info("Tài khoản đã tồn tại " + loginDTO.getEmail());
        return validate(context, user);
    }

    @POST
    @Path("/refresh")
    public Response refresh(@Context SecurityContext context, TokenDTO token) {
        if (token.getToken() == null) {
            throw new BadRequestException("Token can not be empty !");
        }
        try {
            JsonNode claims = jwtUtil.validate(token.getToken());
            return validate(context, userService.getById(jwtUtil.getId(claims)));
        } catch (Exception e) {
            throw new SecurityException(e.getMessage());
        }
    }

    @POST
    @Path("/register")
    @Produces(MediaType.APPLICATION_JSON)
    public UserDTO register(@Context SecurityContext context, RegisterDTO registerDTO) throws BadRequestException {
        if (registerDTO.getName() == null || registerDTO.getEmail() == null || registerDTO.getPassword() == null || registerDTO.getUsername() == null) {
            throw new BadRequestException("Missing information to register for an account !");
        }
        User user = userService.findByUsernameOrEmail(registerDTO.getUsername(), registerDTO.getEmail());
        if (user != null) {
            throw new BadRequestException("The account already exist !");
        }
        registerDTO.setPassword(BcryptUtil.bcryptHash(registerDTO.getPassword(), 10));
        User newUser = userService.createWithRegister(registerDTO);
        this.sendMailConfirm((ClientPrincipal) context.getUserPrincipal(), newUser.getId(), newUser.getName(), newUser.getEmail());
        return new UserDTO(newUser);
    }

    @POST
    @Path("/renew")
    @Produces(MediaType.APPLICATION_JSON)
    public CheckDTO renewTokenToVerify(@Context SecurityContext context, @Email @QueryParam("email") String email) {
        if (email == null) {
            throw new BadRequestException("Token can not be empty !");
        }
        User user = userService.findByEmail(email);
        if (user == null) {
            throw new UnauthorizedException("User is not exist !");
        }
        if (Boolean.TRUE.equals(user.getActive())) {
            throw new BadRequestException("Account has been activated !");
        }
        this.sendMailConfirm((ClientPrincipal) context.getUserPrincipal(), user.getId(), user.getName(), user.getEmail());
        return new CheckDTO(true);
    }

    @POST
    @Path("/password")
    @Produces(MediaType.APPLICATION_JSON)
    public CheckDTO verifyPassword(@Context SecurityContext context, @Email @QueryParam("email") String email) throws BadRequestException {
        if (email == null) {
            throw new BadRequestException("Email must not null !");
        }
        User user = userService.findByEmail(email);
        if (user == null) {
            throw new BadRequestException("User is not exist !");
        }
        try {
            ClientPrincipal principal = (ClientPrincipal) context.getUserPrincipal();
            this.sendMailResetPassword(user.getEmail(), user.getName(), principal.getDomain() + "/verify/password?token=" + jwtUtil.builderTokenToVerify(user.getId()));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return new CheckDTO(true);
    }

    @POST
    @Path("/email")
    @Produces(MediaType.APPLICATION_JSON)
    public CheckDTO verifyEmail(@QueryParam("token") String token) throws BadRequestException {
        User user = this.findByToken(token);
        if (Boolean.TRUE.equals(user.getActive())) {
            throw new BadRequestException("Account has been activated !");
        }
        user.setActive(true);
        userService.save(user);
        return new CheckDTO(true);
    }

    @POST
    @Path("/reset")
    @Produces(MediaType.APPLICATION_JSON)
    public CheckDTO resetPassword(@QueryParam("token") String token, @Valid ResetPassword resetPassword) throws BadRequestException {
        if (resetPassword.getNewPassword() == null || resetPassword.getReNewPassword() == null) {
            throw new BadRequestException("Reset password failed !");
        }
        if (!resetPassword.getNewPassword().equals(resetPassword.getReNewPassword())) {
            throw new BadRequestException("Password does not match !");
        }
        User user = this.findByToken(token);
        user.setPassword(BcryptUtil.bcryptHash(resetPassword.getNewPassword(), 10));
        userService.save(user);
        return new CheckDTO(true);
    }

    private Response validate(SecurityContext context, User user) {
        if (user == null) {
            throw new UnauthorizedException("Tài khoản không thể rỗng !");
        }
        if (Boolean.FALSE.equals(user.getEnabled())) {
            throw new UnauthorizedException("User have not permission to login !");
        }
        // Lấy danh sách cho phép
        List<?> authorities = userAuthorityService.findByUserId(user.getId());
        if (authorities == null) {
            throw new UnauthorizedException("Tài khoản của bạn hiện không có vai trò nào để đăng nhập !");
        }
        ClientPrincipal principal = (ClientPrincipal) context.getUserPrincipal();
        JwtToken token = jwtUtil.builder(user.getId(), authorities, principal);
        return Response
                .ok(token, MediaType.APPLICATION_JSON)
                .header(HttpHeaders.CACHE_CONTROL, "no-cache")
                .header(HttpHeaders.SET_COOKIE, RequestFilter.TOKEN_COOKIE_NAME + "=" + token.getAccess() + ";Max-Age=" + principal.getAccess() + ";Path=/;Secure;HttpOnly;SameSite=None")
                .build();
    }

    private void sendMailConfirm(ClientPrincipal authentication, UUID id, String name, String email) {
        try {
            String builder = "Xin chào " + name + " !\n" +
                    "Truy cập liên kết này để xác minh địa chỉ email của bạn.\n" +
                    authentication.getDomain() + HomeRoute.PATH_VERIFY_EMAIL + "?t=" + jwtUtil.builderTokenToVerify(id) + "\n" +
                    "Nếu bạn không yêu cầu xác minh địa chỉ email này, bạn có thể bỏ qua email này.\n" +
                    "Cảm ơn bạn!\n";
            mailer.send(Mail.withText(email, "Xác minh email của bạn", builder));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    public void sendMailResetPassword(String to, String name, String url) throws IOException {
        try {
            String builder = "Xin chào " + name + " !\n" +
                    "Truy cập liên kết này để đặt lại mật khẩu cho tài khoản " + name + " của bạn.\n" +
                    url + "\n" +
                    "Nếu bạn không yêu cầu đặt lại mật khẩu, bạn có thể bỏ qua email này.\n" +
                    "Cảm ơn bạn!\n";
            mailer.send(Mail.withText(to, "Đặt lại mật khẩu của bạn", builder));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    private User createUser(SocialLoginDTO loginDTO) {
        List<?> userSocialNetworks = null;
        try {
            logger.info("Đã load vào createUser - findByEmail " + loginDTO.getEmail());
            userSocialNetworks = userSocialNetworkService.findByEmail(loginDTO.getEmail());
            logger.info("Đã load xong createUser - findByEmail " + loginDTO.getEmail());
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        logger.info("Đã load xong qua đây để kiểm tra null");
        if (userSocialNetworks == null || userSocialNetworks.isEmpty()) {
            try {
                logger.info("Đã load vào createUser - createWithSocial");
                loginDTO.setUsername(loginDTO.getEmail());
                loginDTO.setPassword(BcryptUtil.bcryptHash(RandomUtil.random(20), 10));
                logger.info("Đã load vào createUser - BcryptUtil.bcryptHash");
                return userService.createWithSocial(loginDTO);
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        } else {
            logger.info("Đã load xong mà này !");
            try {
                for (Object socialNetworks : userSocialNetworks) {
                    Object[] objects = (Object[]) socialNetworks;
                    Social social = Social.valueOf(objects[1].toString());
                    if (loginDTO.getSocial().equals(social)) {
                        return userService.getById(UUID.fromString(objects[0].toString()));
                    }
                }
                User user = userService.findByEmail(loginDTO.getEmail());
                userSocialNetworkService.create(loginDTO, user);
                return user;
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        logger.info("Đã load xong mà sida");
        return null;
    }

    private User findByToken(String token) throws BadRequestException {
        if (token == null) {
            throw new BadRequestException("Token must not null !");
        }
        UUID id;
        try {
            id = jwtUtil.getId(jwtUtil.validate(token));
        } catch (Exception e) {
            throw new BadRequestException("Verify email was failed !");
        }
        if (id == null) {
            throw new BadRequestException("Verify email was failed !");
        }
        User user = userService.getById(id);
        if (user == null) {
            throw new BadRequestException("User is not exist !");
        }
        return user;
    }
}
