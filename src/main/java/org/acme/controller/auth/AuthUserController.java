package org.acme.controller.auth;

import org.acme.base.BaseController;
import org.acme.base.auth.JwtPrincipal;
import org.acme.base.dto.CheckDTO;
import org.acme.constants.SecurityPath;
import org.acme.model.User;
import org.acme.model.dto.UserDTO;
import org.acme.service.UserService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.SecurityContext;

@Path(SecurityPath.AUTH_API_URL + "/" + User.PATH)
public class AuthUserController extends BaseController {

    @Inject
    UserService service;

    @GET
    @Produces("application/json")
    public UserDTO get(@Context SecurityContext context) {
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        return service.findDTOById(principal.getId());
    }

    @PUT
    @Produces("application/json")
    public CheckDTO update(@Context SecurityContext context, UserDTO userDTO) {
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        try {
            User user = service.getById(principal.getId());
            userDTO.setActive(user.getActive());
            user.update(userDTO);
            // SQL update
            service.update(user);
            return new CheckDTO(true);
        } catch (Exception e) {
            return new CheckDTO(false);
        }
    }
}
