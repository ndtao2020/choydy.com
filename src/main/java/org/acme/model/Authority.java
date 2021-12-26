package org.acme.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.acme.model.base.AuthorityBase;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

@Entity
@Table
public class Authority extends AuthorityBase {

    @Transient
    public static final String PATH = "authority";
    @Transient
    public static final String PATH_ID = "authority_id";

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = Authority.PATH)
    private transient List<UserAuthority> accountAuthorities;

    public Authority() {
    }

    public List<UserAuthority> getAccountAuthorities() {
        return accountAuthorities;
    }

    public void setAccountAuthorities(List<UserAuthority> accountAuthorities) {
        this.accountAuthorities = accountAuthorities;
    }
}
