package org.acme;

import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerResponseContext;
import javax.ws.rs.container.ContainerResponseFilter;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.Provider;
import java.io.IOException;

@Provider
public class ResponseFilter implements ContainerResponseFilter {

    @Override
    public void filter(ContainerRequestContext requestContext, ContainerResponseContext responseContext) throws IOException {
        String path = requestContext.getUriInfo().getPath();
        if (path.startsWith("/admin")) {
            // Check if cookie already exists
            if (!requestContext.getCookies().containsKey(RequestFilter.TOKEN_COOKIE_NAME)) {
                // Issue a new token
                responseContext.getHeaders().add(HttpHeaders.LOCATION, "/login?redirect=/admin");
                responseContext.setStatus(Response.Status.MOVED_PERMANENTLY.getStatusCode());
            }
        }
    }
}
