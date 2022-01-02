package org.acme;

import io.vertx.core.http.HttpServerRequest;
import org.acme.base.CsrfUtil;

import javax.inject.Inject;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerResponseContext;
import javax.ws.rs.container.ContainerResponseFilter;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.ext.Provider;
import java.io.IOException;

@Provider
public class ResponseFilter implements ContainerResponseFilter {

    @Inject
    CsrfUtil csrf;
    @Context
    HttpServerRequest request;

    @Override
    public void filter(ContainerRequestContext requestContext, ContainerResponseContext responseContext) throws IOException {
        // Check if cookie already exists
        if (!requestContext.getCookies().containsKey(RequestFilter.CSRF_COOKIE_NAME)) {
            // Issue a new token
            responseContext.getHeaders()
                    .add(HttpHeaders.SET_COOKIE, RequestFilter.CSRF_COOKIE_NAME + "=" + csrf.compact(request.remoteAddress().toString()) + ";Path=/;Secure;HttpOnly;SameSite=None");
        }
    }
}
