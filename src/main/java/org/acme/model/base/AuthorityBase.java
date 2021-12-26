package org.acme.model.base;

import org.acme.constants.Role;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@MappedSuperclass
public abstract class AuthorityBase {

    @Id
    @NotNull
    @NotBlank
    @GeneratedValue
    @Enumerated(EnumType.STRING)
    @Column(updatable = false, nullable = false, unique = true)
    private Role id;

    @NotNull
    @Column(nullable = false)
    private String name;

    public AuthorityBase() {

    }

    protected AuthorityBase(AuthorityBase authority) {
        this.id = Role.valueOf(authority.getAuthority());
        this.name = authority.getName();
    }

    public String getAuthority() {
        return this.id.name();
    }

    public Role getId() {
        return id;
    }

    public void setId(Role id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
