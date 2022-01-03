package org.acme.base.auth;

import javax.ws.rs.core.SecurityContext;
import java.security.Principal;

public class SessionAuthentication implements SecurityContext {

    private final SessionPrincipal p;

    public SessionAuthentication(String i) {
        this.p = new SessionPrincipal(i);
    }

    @Override
    public Principal getUserPrincipal() {
        return p;
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
