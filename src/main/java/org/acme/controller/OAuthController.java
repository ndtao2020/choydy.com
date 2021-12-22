package org.acme.controller;

import com.fasterxml.jackson.databind.JsonNode;
import io.quarkus.security.UnauthorizedException;
import org.acme.RequestFilter;
import org.acme.base.auth.ClientPrincipal;
import org.acme.base.dto.CheckDTO;
import org.acme.base.dto.JwtToken;
import org.acme.base.dto.LoginDTO;
import org.acme.base.dto.RegisterDTO;
import org.acme.base.dto.ResetPassword;
import org.acme.base.dto.SocialLoginDTO;
import org.acme.base.dto.TokenDTO;
import org.acme.base.encoder.BCryptPasswordEncoder;
import org.acme.base.jwt.JwtUtil;
import org.acme.constants.SecurityPath;
import org.acme.model.User;
import org.acme.model.UserSocialNetwork;
import org.acme.model.dto.UserDTO;
import org.acme.service.UserAuthorityService;
import org.acme.service.UserService;
import org.acme.service.UserSocialNetworkService;
import org.acme.utils.EmailUtil;
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
    BCryptPasswordEncoder passwordEncoder;
    @Inject
    UserAuthorityService userAuthorityService;
    @Inject
    UserSocialNetworkService userSocialNetworkService;

    @POST
    @Path("/login")
    public Response login(@Context SecurityContext context, LoginDTO loginDTO) throws SQLException {
        if (loginDTO.getUsername() == null || loginDTO.getPassword() == null) {
            throw new BadRequestException("Username and Password can not be empty !");
        }
        User user = userService.loadUserByUsername(loginDTO.getUsername());
        if (user == null || !passwordEncoder.matches(loginDTO.getPassword(), user.getPassword())) {
            throw new UnauthorizedException("User is not exist !");
        }
        return validate(context, user);
    }

    @POST
    @Path("/social")
    public Response loginBySocial(@Context SecurityContext context, @Valid SocialLoginDTO loginDTO) throws UnauthorizedException, BadRequestException, SQLException {
        if (loginDTO.getEmail() == null || loginDTO.getPassword() == null) {
            throw new BadRequestException("Email and Password can not be empty !");
        }
        User user = userService.loadUserByUsername(loginDTO.getEmail());
        if (user == null) {
            user = createUser((ClientPrincipal) context.getUserPrincipal(), loginDTO);
        }
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
        registerDTO.setPassword(passwordEncoder.encode(registerDTO.getPassword()));
        User newUser = userService.create(registerDTO);
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
            EmailUtil.sendMailResetPassword(user.getEmail(), user.getName(), principal.getDomain() + "/verify/password?token=" + jwtUtil.builderTokenToVerify(user.getId()));
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
        user.setPassword(passwordEncoder.encode(resetPassword.getNewPassword()));
        userService.save(user);
        return new CheckDTO(true);
    }

    private Response validate(SecurityContext context, User user) {
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
            EmailUtil.sendMailConfirm(email, name, authentication.getDomain() + "/verify/email?token=" + jwtUtil.builderTokenToVerify(id));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    private User createUser(ClientPrincipal principal, SocialLoginDTO loginDTO) {
        User user;
        List<UserSocialNetwork> userSocialNetworks = userSocialNetworkService.findByEmail(loginDTO.getEmail());
        if (userSocialNetworks == null || userSocialNetworks.isEmpty()) {
            loginDTO.setUsername(loginDTO.getEmail());
            try {
                loginDTO.setPassword(passwordEncoder.encode(UUID.randomUUID().toString()));
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            user = userService.create(loginDTO);
            assert user.getId() != null;
            UserDTO dto = userService.findDTOById(user.getId());
            this.sendMailConfirm(principal, user.getId(), dto.getName(), dto.getEmail());
        } else {
            UserSocialNetwork userSocialNetwork = null;
            for (UserSocialNetwork s : userSocialNetworks) {
                if (s.getSocialNetwork().getName().equals(loginDTO.getSocial())) {
                    userSocialNetwork = s;
                    break;
                }
            }
            if (userSocialNetwork == null) {
                user = userSocialNetworks.get(0).getUser();
                userSocialNetworkService.create(loginDTO, user);
            } else {
                user = userSocialNetwork.getUser();
            }
        }
        return user;
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
