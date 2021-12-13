package org.acme;

import com.fasterxml.jackson.databind.JsonNode;
import org.acme.base.auth.ClientAuthentication;
import org.acme.base.encoder.BCryptPasswordEncoder;
import org.acme.base.jwt.JwtUtil;
import org.acme.constants.Role;
import org.acme.constants.SecurityPath;
import org.acme.model.Oauth2Client;
import org.acme.service.Oauth2ClientService;
import org.jboss.logging.Logger;
import org.jboss.resteasy.core.Headers;
import org.jboss.resteasy.core.ServerResponse;

import javax.inject.Inject;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.container.PreMatching;
import javax.ws.rs.ext.Provider;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Provider
@PreMatching
public class RequestFilter implements ContainerRequestFilter {

    public static final String CSRF_TOKEN_COOKIE_NAME = "csrf";
    private static final String AUTHORIZATION = "AUTHORIZATION";
    private static final ServerResponse ACCESS_DENIED = new ServerResponse("Access denied for this resource", 401, new Headers<>());

    @Inject
    Logger log;
    @Inject
    JwtUtil jwtUtil;
    @Inject
    BCryptPasswordEncoder passwordEncoder;
    @Inject
    Oauth2ClientService oauth2ClientService;

    @Override
    public void filter(ContainerRequestContext requestContext) {
        String path = requestContext.getUriInfo().getPath();
        if (path.startsWith(SecurityPath.OAUTH_API_URL)) {
            final List<String> apiKeyHeader = requestContext.getHeaders().get(AUTHORIZATION);
            if (Objects.isNull(apiKeyHeader) || apiKeyHeader.isEmpty()) {
                requestContext.abortWith(ACCESS_DENIED);
                return;
            }
            this.basicAuth(requestContext);
        } else if (path.startsWith(SecurityPath.AUTH_API_URL)) {
            this.bearerAuth(requestContext, null);
        } else if (path.startsWith(SecurityPath.EDITOR_API_URL)) {
            this.bearerAuth(requestContext, Role.EDITOR);
        } else if (path.startsWith(SecurityPath.ADMIN_API_URL)) {
            this.bearerAuth(requestContext, Role.ADMIN);
        }
    }

    private void bearerAuth(ContainerRequestContext requestContext, Role role) {
        final List<String> apiKeyHeader = requestContext.getHeaders().get(AUTHORIZATION);
        if (Objects.isNull(apiKeyHeader) || apiKeyHeader.isEmpty()) {
            requestContext.abortWith(ACCESS_DENIED);
            return;
        }
        try {
            JsonNode jsonNode = jwtUtil.validate(apiKeyHeader.get(0).substring(7));
            if (role != null) {
                boolean c = true;
                Iterator<JsonNode> roles = jwtUtil.getRoles(jsonNode);
                while (roles.hasNext()) {
                    if (role.toString().equals(roles.next().asText())) {
                        c = false;
                        break;
                    }
                }
                if (c) {
                    requestContext.abortWith(ACCESS_DENIED);
                    return;
                }
            }
            requestContext.setSecurityContext(jwtUtil.parse(jsonNode));
        } catch (Exception e) {
            log.error(e.getMessage());
            requestContext.abortWith(new ServerResponse(e.getMessage(), 401, null));
        }
    }

    private void basicAuth(ContainerRequestContext requestContext) {
        final List<String> apiKeyHeader = requestContext.getHeaders().get(AUTHORIZATION);
        if (Objects.isNull(apiKeyHeader) || apiKeyHeader.isEmpty()) {
            requestContext.abortWith(ACCESS_DENIED);
            return;
        }
        String h = apiKeyHeader.get(0);
        if (!h.startsWith("Basic")) {
            log.error("Invalid basic authentication token !");
            requestContext.abortWith(ACCESS_DENIED);
            return;
        }
        try {
            String t = new String(Base64.getDecoder().decode(h.substring(6).getBytes(StandardCharsets.UTF_8)), StandardCharsets.UTF_8);
            int l = t.indexOf(":");
            if (l == -1) {
                log.error("Invalid basic authentication token !");
                requestContext.abortWith(ACCESS_DENIED);
                return;
            }
            Oauth2Client oauth2Client = oauth2ClientService.loadClientByClientId(UUID.fromString(t.substring(0, l)));
            if (!passwordEncoder.matches(t.substring(l + 1), oauth2Client.getSecret())) {
                log.error("Authentication failed: secret is not matched !");
                requestContext.abortWith(ACCESS_DENIED);
                return;
            }
            requestContext.setSecurityContext(new ClientAuthentication(oauth2Client));
        } catch (Exception e) {
            log.error(e.getMessage());
            requestContext.abortWith(ACCESS_DENIED);
        }
    }
}
