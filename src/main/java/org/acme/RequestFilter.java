package org.acme;

import com.fasterxml.jackson.databind.JsonNode;
import io.quarkus.runtime.LaunchMode;
import org.acme.base.auth.ClientAuthentication;
import org.acme.base.encoder.BCryptPasswordEncoder;
import org.acme.base.jwt.JwtUtil;
import org.acme.constants.Role;
import org.acme.constants.SecurityPath;
import org.acme.service.Oauth2ClientService;
import org.jboss.logging.Logger;
import org.jboss.resteasy.core.Headers;
import org.jboss.resteasy.core.ServerResponse;

import javax.inject.Inject;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.container.PreMatching;
import javax.ws.rs.core.Cookie;
import javax.ws.rs.ext.Provider;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;

@Provider
@PreMatching
public class RequestFilter implements ContainerRequestFilter {

    public static final String TOKEN_COOKIE_NAME = (LaunchMode.current().equals(LaunchMode.NORMAL) ? "__Host-" : "") + "cid";
    private static final Logger logger = Logger.getLogger(Oauth2ClientService.class);
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

    private boolean checkRole(JsonNode jsonNode, Role role) {
        Iterator<JsonNode> roles = jwtUtil.getRoles(jsonNode);
        while (roles.hasNext()) {
            if (role.toString().equals(roles.next().asText())) {
                return true;
            }
        }
        return false;
    }

    private void bearerAuth(ContainerRequestContext rc, Role role) {
        String token;
        final List<String> apiKeyHeader = rc.getHeaders().get(AUTHORIZATION);
        if (Objects.isNull(apiKeyHeader) || apiKeyHeader.isEmpty()) {
            Cookie tokenCookie = rc.getCookies().get(TOKEN_COOKIE_NAME);
            if (tokenCookie == null) {
                rc.abortWith(ACCESS_DENIED);
                return;
            }
            token = tokenCookie.getValue();
        } else {
            token = apiKeyHeader.get(0).substring(7);
        }
        try {
            JsonNode jsonNode = jwtUtil.validate(token);
            if (role != null && !checkRole(jsonNode, role)) {
                rc.abortWith(ACCESS_DENIED);
                return;
            }
            rc.setSecurityContext(jwtUtil.parse(jsonNode));
        } catch (Exception e) {
            logger.error(e.getMessage());
            rc.abortWith(new ServerResponse(e.getMessage(), 401, null));
        }
    }

    private void basicAuth(ContainerRequestContext rc) {
        final List<String> apiKeyHeader = rc.getHeaders().get(AUTHORIZATION);
        if (Objects.isNull(apiKeyHeader) || apiKeyHeader.isEmpty()) {
            rc.abortWith(ACCESS_DENIED);
            return;
        }
        String h = apiKeyHeader.get(0);
        if (!h.startsWith("Basic")) {
            logger.error("Invalid basic authentication token !");
            rc.abortWith(ACCESS_DENIED);
            return;
        }
        try {
            String t = new String(Base64.getDecoder().decode(h.substring(6).getBytes(StandardCharsets.UTF_8)), StandardCharsets.UTF_8);
            int l = t.indexOf(":");
            if (l == -1) {
                logger.error("Invalid basic authentication token !");
                rc.abortWith(ACCESS_DENIED);
                return;
            }
            Object[] r = oauth2ClientService.loadShortByClientId(t.substring(0, l));
            if (!passwordEncoder.matches(t.substring(l + 1), r[0].toString())) {
                logger.error("Authentication failed: secret is not matched !");
                rc.abortWith(ACCESS_DENIED);
                return;
            }
            rc.setSecurityContext(new ClientAuthentication(r[1], r[2], r[3].toString()));
        } catch (Exception e) {
            logger.error(e.getMessage());
            rc.abortWith(ACCESS_DENIED);
        }
    }
}
