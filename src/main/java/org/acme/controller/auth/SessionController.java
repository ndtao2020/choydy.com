package org.acme.controller.auth;

import org.acme.RequestFilter;
import org.acme.base.dto.CheckDTO;
import org.acme.constants.SecurityPath;

import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;
import java.security.Principal;

@Path(SecurityPath.AUTH_API_URL + "/est")
public class SessionController {

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Principal get(@Context SecurityContext context) {
        return context.getUserPrincipal();
    }

    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    public Response logout(@Context SecurityContext context) {
        return Response
                .ok(new CheckDTO(true))
                .header(HttpHeaders.CACHE_CONTROL, "no-cache")
                .header(HttpHeaders.SET_COOKIE, RequestFilter.TOKEN_COOKIE_NAME + "=bye;path=/;expires=Thu, 01 Jan 1970 00:00:00 GMT")
                .build();
    }
}
