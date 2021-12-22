package org.acme.base.auth;

import java.security.Principal;

public class ClientPrincipal implements Principal {

    private final Object a;
    private final Object r;
    private final String d;

    public ClientPrincipal(Object access, Object refresh, String domain) {
        this.a = access;
        this.r = refresh;
        this.d = domain;
    }

    @Override
    public String getName() {
        return d;
    }

    public Integer getAccess() {
        if (a instanceof Integer) {
            return (Integer) a;
        }
        return Integer.parseInt(a.toString());
    }

    public Integer getRefresh() {
        if (r instanceof Integer) {
            return (Integer) r;
        }
        return Integer.parseInt(r.toString());
    }

    public String getDomain() {
        return d;
    }
}
