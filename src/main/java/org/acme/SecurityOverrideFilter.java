package org.acme;

import org.acme.base.auth.ClientAuthentication;
import org.acme.base.encoder.BCryptPasswordEncoder;
import org.acme.base.jwt.JwtUtil;
import org.acme.constants.SecurityPath;
import org.acme.model.Oauth2Client;
import org.acme.service.Oauth2ClientService;
import org.jboss.resteasy.core.Headers;
import org.jboss.resteasy.core.ServerResponse;

import javax.inject.Inject;
import javax.security.sasl.AuthenticationException;
import javax.ws.rs.HttpMethod;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.container.PreMatching;
import javax.ws.rs.core.Cookie;
import javax.ws.rs.ext.Provider;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Provider
@PreMatching
public class SecurityOverrideFilter implements ContainerRequestFilter {

    public static final String CSRF_TOKEN_COOKIE_NAME = "csrf";
    private static final String CSRF_TOKEN_HEADER_NAME = "X-XSRF-TOKEN";
    private static final String AUTHORIZATION = "AUTHORIZATION";
    private static final ServerResponse ACCESS_DENIED = new ServerResponse("Access denied for this resource", 401, new Headers<>());

    @Inject
    JwtUtil jwtUtil;
    @Inject
    BCryptPasswordEncoder passwordEncoder;
    @Inject
    Oauth2ClientService oauth2ClientService;

    @Override
    public void filter(ContainerRequestContext requestContext) {
        String path = requestContext.getUriInfo().getPath();
        if (!Objects.equals(requestContext.getMethod(), HttpMethod.GET)) {
            Cookie csrfTokenCookie = requestContext.getCookies().get(CSRF_TOKEN_COOKIE_NAME);
            List<String> csrfTokenHeader = requestContext.getHeaders().get(CSRF_TOKEN_HEADER_NAME);
            if (csrfTokenCookie == null || csrfTokenHeader == null || csrfTokenHeader.size() != 1 || !csrfTokenHeader.get(0).equals(csrfTokenCookie.getValue())) {
                requestContext.abortWith(ACCESS_DENIED);
                return;
            }
        }
        if (path.startsWith(SecurityPath.AUTH_API_URL)) {
            final List<String> apiKeyHeader = requestContext.getHeaders().get(AUTHORIZATION);
            if (Objects.isNull(apiKeyHeader) || apiKeyHeader.isEmpty()) {
                requestContext.abortWith(ACCESS_DENIED);
                return;
            }
            this.bearerAuth(requestContext, apiKeyHeader.get(0));
        } else if (path.startsWith(SecurityPath.OAUTH_API_URL)) {
            final List<String> apiKeyHeader = requestContext.getHeaders().get(AUTHORIZATION);
            if (Objects.isNull(apiKeyHeader) || apiKeyHeader.isEmpty()) {
                requestContext.abortWith(ACCESS_DENIED);
                return;
            }
            this.basicAuth(requestContext, apiKeyHeader.get(0));
        }
    }

    private void bearerAuth(ContainerRequestContext requestContext, String h) {
        try {
            requestContext.setSecurityContext(jwtUtil.parse(jwtUtil.validate(h.substring(7))));
        } catch (Exception e) {
            requestContext.abortWith(new ServerResponse(e.getMessage(), 401, null));
        }
    }

    private void basicAuth(ContainerRequestContext requestContext, String h) {
        if (h == null) {
            requestContext.abortWith(new ServerResponse("Authorization Header not found !", 401, null));
            return;
        }
        if (!h.startsWith("Basic")) {
            requestContext.abortWith(new ServerResponse("Invalid basic authentication token !", 401, null));
            return;
        }
        try {
            String t = new String(Base64.getDecoder().decode(h.substring(6).getBytes(StandardCharsets.UTF_8)), StandardCharsets.UTF_8);
            int l = t.indexOf(":");
            if (l == -1) {
                requestContext.abortWith(new ServerResponse("Invalid basic authentication token !", 401, null));
                return;
            }
            Oauth2Client oauth2Client = oauth2ClientService.loadClientByClientId(UUID.fromString(t.substring(0, l)));
            if (!passwordEncoder.matches(t.substring(l + 1), oauth2Client.getSecret())) {
                throw new AuthenticationException("Authentication failed: secret is not matched !");
            }
            requestContext.setSecurityContext(new ClientAuthentication(oauth2Client));
        } catch (Exception e) {
            requestContext.abortWith(new ServerResponse(e.getMessage(), 401, null));
        }
    }
}
