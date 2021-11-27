package org.acme.base.auth;

import org.acme.model.Oauth2Client;

import java.security.Principal;
import java.util.UUID;

public class ClientPrincipal implements Principal {

    private final UUID id;
    private final Integer accessTokenValidity;
    private final Integer refreshTokenValidity;
    private final String domain;

    public ClientPrincipal(Oauth2Client client) {
        this.id = client.getId();
        this.accessTokenValidity = client.getAccessTokenValidity();
        this.refreshTokenValidity = client.getRefreshTokenValidity();
        this.domain = client.getDomain();
    }

    @Override
    public String getName() {
        return id.toString();
    }

    public Integer getAccessTokenValidity() {
        return accessTokenValidity;
    }

    public Integer getRefreshTokenValidity() {
        return refreshTokenValidity;
    }

    public String getDomain() {
        return domain;
    }
}
