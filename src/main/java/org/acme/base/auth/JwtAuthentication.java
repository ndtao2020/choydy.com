package org.acme.base.auth;

import javax.ws.rs.core.SecurityContext;
import java.security.Principal;
import java.util.UUID;

public class JwtAuthentication implements SecurityContext {

    private final JwtPrincipal p;

    public JwtAuthentication(UUID i) throws IllegalArgumentException {
        if (i == null) {
            throw new IllegalArgumentException("Id must not null !");
        }
        this.p = new JwtPrincipal(i);
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
