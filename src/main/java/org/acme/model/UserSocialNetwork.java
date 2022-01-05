package org.acme.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.acme.constants.Social;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serial;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table
public class UserSocialNetwork implements Serializable {

    @Transient
    public static final String PATH = "usersocialnetwork";
    @Serial
    private static final long serialVersionUID = -78834L;

    @Id
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = User.PATH_ID, nullable = false)
    private User user;

    @Id
    @NotNull
    @NotBlank
    @Column(length = 150, nullable = false)
    @Enumerated(EnumType.STRING)
    private Social social;

    @Column(nullable = false)
    private String uid;

    @Column(nullable = false)
    private String email;

    private String phoneNumber;

    public UserSocialNetwork() {
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Social getSocial() {
        return social;
    }

    public void setSocial(Social social) {
        this.social = social;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserSocialNetwork that = (UserSocialNetwork) o;
        return user.equals(that.user) && social == that.social && Objects.equals(uid, that.uid) && email.equals(that.email) && Objects.equals(phoneNumber, that.phoneNumber);
    }

    @Override
    public int hashCode() {
        return Objects.hash(user, social, uid, email, phoneNumber);
    }
}
