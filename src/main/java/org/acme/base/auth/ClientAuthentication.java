package org.acme.base.auth;

import org.acme.model.Oauth2Client;

import javax.ws.rs.core.SecurityContext;
import java.security.Principal;

public class ClientAuthentication implements SecurityContext {

    private final ClientPrincipal principal;

    public ClientAuthentication(Oauth2Client client) {
        this.principal = new ClientPrincipal(client);
    }

    @Override
    public Principal getUserPrincipal() {
        return principal;
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
