package org.acme.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.User;
import org.acme.model.base.UserBase;

@Getter
@Setter
@NoArgsConstructor
public class UserDTO extends UserBase {

    private UserDetailDTO detail;

    public UserDTO(User user) {
        super(user);
    }
}
