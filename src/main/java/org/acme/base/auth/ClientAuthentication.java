package org.acme.base.auth;

import org.acme.model.Oauth2Client;

import javax.ws.rs.core.SecurityContext;
import java.security.Principal;

public class ClientAuthentication implements SecurityContext {

    private final ClientPrincipal p;

    public ClientAuthentication(Oauth2Client c) {
        this(c.getAccess(), c.getRefresh(), c.getDomain());
    }

    public ClientAuthentication(Object a, Object r, String d) {
        this.p = new ClientPrincipal(a, r, d);
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
        return "basic";
    }
}
