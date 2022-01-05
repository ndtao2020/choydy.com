package org.acme.controller.auth;

import org.acme.base.BaseController;
import org.acme.base.auth.JwtPrincipal;
import org.acme.constants.SecurityPath;
import org.acme.model.UserSocialNetwork;
import org.acme.service.UserSocialNetworkService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;
import java.util.List;

@Path(SecurityPath.AUTH_API_URL + "/" + UserSocialNetwork.PATH)
public class UserSocialNetworkController extends BaseController {

    @Inject
    UserSocialNetworkService userSocialNetworkService;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> socials(@Context SecurityContext context) {
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        return userSocialNetworkService.findByUserId(principal.getId());
    }
}
