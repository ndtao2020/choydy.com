package org.acme.base.auth;

import java.security.Principal;

public class ClientPrincipal implements Principal {

    private final Object a;
    private final Object r;
    private final String d;

    public ClientPrincipal(Object accessTokenValidity, Object refreshTokenValidity, String domain) {
        this.a = accessTokenValidity;
        this.r = refreshTokenValidity;
        this.d = domain;
    }

    @Override
    public String getName() {
        return d;
    }

    public Integer getAccessTokenValidity() {
        if (a instanceof Integer) {
            return (Integer) a;
        }
        return Integer.parseInt(a.toString());
    }

    public Integer getRefreshTokenValidity() {
        if (r instanceof Integer) {
            return (Integer) r;
        }
        return Integer.parseInt(r.toString());
    }

    public String getDomain() {
        return d;
    }
}
