package org.acme.base.auth;

import java.security.Principal;
import java.util.UUID;

public record JwtPrincipal(UUID i) implements Principal {

    public UUID getId() {
        return i;
    }

    @Override
    public String getName() {
        return i.toString();
    }
}
