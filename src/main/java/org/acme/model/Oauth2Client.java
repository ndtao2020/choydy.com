package org.acme.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Getter
@Setter
@Table
@NoArgsConstructor
public class Oauth2Client extends BaseId<String> {

    @Transient
    public static final String PATH = "oauth2client";

    @Column(nullable = false)
    private String secret;

    @Column(nullable = false)
    private Boolean approve;

    @Column(nullable = false)
    private Integer access;

    @Column(nullable = false)
    private Integer refresh;

    @Column(nullable = false)
    private String domain;

    private String redirect;
}
