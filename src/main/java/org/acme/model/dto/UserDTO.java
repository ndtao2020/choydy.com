package org.acme.model.dto;

import org.acme.model.User;
import org.acme.model.base.UserBase;

public class UserDTO extends UserBase {

    private UserDetailDTO detail;

    public UserDTO() {
    }

    public UserDTO(User user) {
        super(user);
    }

    public UserDetailDTO getDetail() {
        return detail;
    }

    public void setDetail(UserDetailDTO detail) {
        this.detail = detail;
    }
}
