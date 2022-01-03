package org.acme.base.auth;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.security.Principal;

public record SessionPrincipal(String i) implements Principal {

    @Override
    @JsonIgnore
    public String getName() {
        return i;
    }
}
