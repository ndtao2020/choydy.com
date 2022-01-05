package org.acme.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.acme.model.base.UserDetailBase;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.io.Serial;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table
public class UserDetail extends UserDetailBase implements Serializable {

    @Transient
    public static final String PATH = "userdetail";
    @Serial
    private static final long serialVersionUID = -89934L;

    @Id
    @JsonIgnore
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(nullable = false)
    private User user;

    @JsonProperty
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false)
    private Country country;

    public UserDetail() {
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Country getCountry() {
        return country;
    }

    public void setCountry(Country country) {
        this.country = country;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserDetail that = (UserDetail) o;
        return user.equals(that.user) && country.equals(that.country);
    }

    @Override
    public int hashCode() {
        return Objects.hash(user, country);
    }
}
