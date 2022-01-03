package org.acme.base.auth;

import java.security.Principal;

public class SessionPrincipal implements Principal {

    private final String i;

    public SessionPrincipal(String i) {
        this.i = i;
    }

    @Override
    public String getName() {
        return i;
    }
}
