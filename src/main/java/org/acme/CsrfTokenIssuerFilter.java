package org.acme;

import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerResponseContext;
import javax.ws.rs.container.ContainerResponseFilter;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.ext.Provider;
import java.io.IOException;
import java.util.UUID;

@Provider
public class CsrfTokenIssuerFilter implements ContainerResponseFilter {

    private static final String CSRF_TOKEN_COOKIE_NAME = SecurityOverrideFilter.CSRF_TOKEN_COOKIE_NAME;

    @Override
    public void filter(ContainerRequestContext requestContext, ContainerResponseContext responseContext) throws IOException {
        // Check if cookie already exists
        MultivaluedMap<String, Object> headers = responseContext.getHeaders();
        if (!requestContext.getCookies().containsKey(CSRF_TOKEN_COOKIE_NAME)) {
            // Issue a new token
            headers.add("Set-Cookie", CSRF_TOKEN_COOKIE_NAME + "=" + UUID.randomUUID() + ";Path=/;Secure;SameSite=None");
        }
    }
}
