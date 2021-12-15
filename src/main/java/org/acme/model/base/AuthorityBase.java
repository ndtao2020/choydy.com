package org.acme.model.base;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.constants.Role;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@MappedSuperclass
@NoArgsConstructor
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

    protected AuthorityBase(AuthorityBase authority) {
        this.id = Role.valueOf(authority.getAuthority());
        this.name = authority.getName();
    }

    public String getAuthority() {
        return this.id.name();
    }
}
