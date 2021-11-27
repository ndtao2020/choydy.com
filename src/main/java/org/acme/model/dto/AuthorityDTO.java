package org.acme.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.Authority;
import org.acme.model.base.AuthorityBase;

@Getter
@Setter
@NoArgsConstructor
public class AuthorityDTO extends AuthorityBase {
    public AuthorityDTO(Authority authority) {
        super(authority);
    }
}
