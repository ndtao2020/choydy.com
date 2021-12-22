package org.acme.base.auth;

import org.acme.model.Oauth2Client;

import javax.ws.rs.core.SecurityContext;
import java.security.Principal;

public class ClientAuthentication implements SecurityContext {

    private final ClientPrincipal p;

    public ClientAuthentication(Oauth2Client client) {
        this(client.getAccess(), client.getRefresh(), client.getDomain());
    }

    public ClientAuthentication(Object accessTokenValidity, Object refreshTokenValidity, String domain) {
        this.p = new ClientPrincipal(accessTokenValidity, refreshTokenValidity, domain);
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
