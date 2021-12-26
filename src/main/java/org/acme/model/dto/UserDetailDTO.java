package org.acme.model.dto;

import org.acme.model.UserDetail;
import org.acme.model.base.UserDetailBase;

import java.util.UUID;

public class UserDetailDTO extends UserDetailBase {

    private UUID userId;
    private String countryIso;

    public UserDetailDTO() {
    }

    public UserDetailDTO(UserDetail userDetail) {
        super(userDetail);
    }

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    public String getCountryIso() {
        return countryIso;
    }

    public void setCountryIso(String countryIso) {
        this.countryIso = countryIso;
    }
}
