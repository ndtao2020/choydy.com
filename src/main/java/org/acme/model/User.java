package org.acme.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.acme.base.dto.RegisterDTO;
import org.acme.model.base.UserBase;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.List;
import java.util.UUID;

@Entity
@Table(
        name = "user_sys",
        uniqueConstraints = @UniqueConstraint(columnNames = {"username", "email"})
)
public class User extends UserBase {

    @Transient
    public static final String PATH = "user";
    @Transient
    public static final String PATH_ID = "user_id";

    @NotNull
    @NotBlank
    @Size(min = 5, max = 100, message = "Username must be between 5 and 100 characters")
    @Column(updatable = false, nullable = false, unique = true)
    private String username;

    @NotNull
    @NotBlank
    @JsonIgnore
    @Size(min = 8, max = 100, message = "Password must be between 8 and 100 characters")
    @Column(nullable = false, length = 100)
    private String password;

    @Column(nullable = false)
    private Boolean enabled;

    @JsonIgnore
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = User.PATH)
    private transient UserDetail userDetail;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = User.PATH)
    private transient List<UserAuthority> userAuthorities;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = User.PATH)
    private transient List<UserSocialNetwork> userSocialNetworks;

    public User() {
    }

    public User(UUID id) {
        super(id);
    }

    public User(RegisterDTO registerDTO) {
        super(registerDTO.getName(), registerDTO.getEmail(), false, registerDTO.getTimezone());
        this.username = registerDTO.getUsername();
        this.password = registerDTO.getPassword();
        this.enabled = true;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public UserDetail getUserDetail() {
        return userDetail;
    }

    public void setUserDetail(UserDetail userDetail) {
        this.userDetail = userDetail;
    }

    public List<UserAuthority> getUserAuthorities() {
        return userAuthorities;
    }

    public void setUserAuthorities(List<UserAuthority> userAuthorities) {
        this.userAuthorities = userAuthorities;
    }

    public List<UserSocialNetwork> getUserSocialNetworks() {
        return userSocialNetworks;
    }

    public void setUserSocialNetworks(List<UserSocialNetwork> userSocialNetworks) {
        this.userSocialNetworks = userSocialNetworks;
    }
}
