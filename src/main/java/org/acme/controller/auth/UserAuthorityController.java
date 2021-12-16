package org.acme.controller.auth;

import org.acme.base.auth.JwtPrincipal;
import org.acme.constants.SecurityPath;
import org.acme.model.UserAuthority;
import org.acme.service.UserAuthorityService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.SecurityContext;
import java.util.List;

@Path(SecurityPath.AUTH_API_URL + "/" + UserAuthority.PATH)
public class UserAuthorityController {

    @Inject
    UserAuthorityService userAuthorityService;

    @GET
    @Produces("application/json")
    public List<?> authorities(@Context SecurityContext context) {
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        return userAuthorityService.findByUserId(principal.getId());
    }
}
