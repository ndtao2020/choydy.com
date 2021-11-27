package org.acme.base.auth;

import java.security.Principal;
import java.util.UUID;

public class JwtPrincipal implements Principal {

    private final UUID i;

    public JwtPrincipal(UUID i) {
        this.i = i;
    }

    public UUID getId() {
        return i;
    }

    @Override
    public String getName() {
        return i.toString();
    }
}
