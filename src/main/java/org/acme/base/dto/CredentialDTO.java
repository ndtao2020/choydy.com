package org.acme.base.dto;

public class CredentialDTO {
    private String accessToken;
    private String idToken;
    private String pendingToken;
    private String providerId;
    private String signInMethod;

    public CredentialDTO() {
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getIdToken() {
        return idToken;
    }

    public void setIdToken(String idToken) {
        this.idToken = idToken;
    }

    public String getPendingToken() {
        return pendingToken;
    }

    public void setPendingToken(String pendingToken) {
        this.pendingToken = pendingToken;
    }

    public String getProviderId() {
        return providerId;
    }

    public void setProviderId(String providerId) {
        this.providerId = providerId;
    }

    public String getSignInMethod() {
        return signInMethod;
    }

    public void setSignInMethod(String signInMethod) {
        this.signInMethod = signInMethod;
    }
}
