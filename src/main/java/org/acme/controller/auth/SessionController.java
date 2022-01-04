package org.acme.controller.auth;

import org.acme.RequestFilter;
import org.acme.base.dto.CheckDTO;

import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;
import java.security.Principal;

@Path(RequestFilter.CHECK_SESSION)
public class SessionController {

    @GET
    public Response get(@Context SecurityContext context) {
        Principal principal = context.getUserPrincipal();
        return Response
                .ok(principal == null ? null : principal.getName(), MediaType.TEXT_PLAIN)
                .header(HttpHeaders.CACHE_CONTROL, "no-cache")
                .build();
    }

    @DELETE
    public Response logout(@Context SecurityContext context) {
        return Response
                .ok(new CheckDTO(true))
                .header(HttpHeaders.CACHE_CONTROL, "no-cache")
                .header(HttpHeaders.SET_COOKIE, RequestFilter.TOKEN_COOKIE_NAME + "=bye;path=/;expires=Thu, 01 Jan 1970 00:00:00 GMT")
                .build();
    }
}
