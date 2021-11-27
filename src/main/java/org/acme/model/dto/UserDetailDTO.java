package org.acme.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.UserDetail;
import org.acme.model.base.UserDetailBase;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
public class UserDetailDTO extends UserDetailBase {

    private UUID userId;
    private String countryIso;

    public UserDetailDTO(UserDetail userDetail) {
        super(userDetail);
    }
}
