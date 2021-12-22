package org.acme.base.dto;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class JwtToken {

    @JsonProperty("access_token")
    private String access;

    @JsonProperty("refresh_token")
    private String refresh;

    @JsonProperty("expires_in")
    private Long expires;

    public JwtToken() {
    }

    public JwtToken(String accessToken, String refreshToken, long expires) {
        this.access = accessToken;
        this.refresh = refreshToken;
        this.expires = expires;
    }

    public String getAccess() {
        return access;
    }

    public void setAccess(String access) {
        this.access = access;
    }

    public String getRefresh() {
        return refresh;
    }

    public void setRefresh(String refresh) {
        this.refresh = refresh;
    }

    public long getExpires() {
        return expires;
    }

    public void setExpires(Long expires) {
        this.expires = expires;
    }
}
