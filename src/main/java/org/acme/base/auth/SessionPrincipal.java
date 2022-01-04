package org.acme.base.auth;

import java.security.Principal;

public record SessionPrincipal(String i) implements Principal {
    @Override
    public String getName() {
        return i;
    }
}
