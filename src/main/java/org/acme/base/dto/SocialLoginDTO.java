package org.acme.base.dto;

import org.acme.constants.Social;

import javax.validation.constraints.NotNull;

public class SocialLoginDTO extends RegisterDTO {

    @NotNull
    private String id;

    @NotNull
    private Social social;

    private String avatar;

    private CredentialDTO credential;

    public SocialLoginDTO() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Social getSocial() {
        return social;
    }

    public void setSocial(Social social) {
        this.social = social;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public CredentialDTO getCredential() {
        return credential;
    }

    public void setCredential(CredentialDTO credential) {
        this.credential = credential;
    }
}
