package org.acme.base.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.io.Serializable;

@Data
public class JwtToken implements Serializable {

    private static final long serialVersionUID = 999944324545L;

    @JsonProperty("access_token")
    private String access;

    @JsonProperty("refresh_token")
    private String refresh;

    @JsonProperty("expires_in")
    private long expires;

    public JwtToken(String accessToken, String refreshToken, long expires) {
        this.access = accessToken;
        this.refresh = refreshToken;
        this.expires = expires;
    }
}
