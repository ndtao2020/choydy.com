package org.acme.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.UUID;

@Entity
@Getter
@Setter
@Table
@NoArgsConstructor
public class Oauth2Client extends BaseId<UUID> {

    @Transient
    public static final String PATH = "oauth2_client";

    @Column(nullable = false)
    private String secret;

    @Column(nullable = false)
    private Boolean approve;

    @Column(nullable = false, name = "access_token_validity")
    private Integer accessTokenValidity;

    @Column(nullable = false, name = "refresh_token_validity")
    private Integer refreshTokenValidity;

    @Column(nullable = false)
    private String domain;

    private String redirect;
}
