package org.acme.model;

import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table
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

    public Oauth2Client() {
    }

    public String getSecret() {
        return secret;
    }

    public void setSecret(String secret) {
        this.secret = secret;
    }

    public Boolean getApprove() {
        return approve;
    }

    public void setApprove(Boolean approve) {
        this.approve = approve;
    }

    public Integer getAccess() {
        return access;
    }

    public void setAccess(Integer access) {
        this.access = access;
    }

    public Integer getRefresh() {
        return refresh;
    }

    public void setRefresh(Integer refresh) {
        this.refresh = refresh;
    }

    public String getDomain() {
        return domain;
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }

    public String getRedirect() {
        return redirect;
    }

    public void setRedirect(String redirect) {
        this.redirect = redirect;
    }
}
