package org.acme.base.auth;

import javax.ws.rs.core.SecurityContext;
import java.security.Principal;

public record SessionAuthentication(String i) implements SecurityContext {

    @Override
    public Principal getUserPrincipal() {
        return new SessionPrincipal(i);
    }

    @Override
    public boolean isUserInRole(String role) {
        return false;
    }

    @Override
    public boolean isSecure() {
        return false;
    }

    @Override
    public String getAuthenticationScheme() {
        return "bearer";
    }
}
