package org.acme.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.base.dto.RegisterDTO;
import org.acme.base.dto.SocialLoginDTO;
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
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
@Table(
        name = "user_sys",
        uniqueConstraints = @UniqueConstraint(columnNames = {"username", "email"})
)
@NoArgsConstructor
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

    public User(UUID id) {
        super(id);
    }

    public User(RegisterDTO registerDTO, Authority authority) {
        super(registerDTO.getName(), registerDTO.getEmail(), false, registerDTO.getTimezone());
        this.username = registerDTO.getUsername();
        this.password = registerDTO.getPassword();
        this.enabled = true;
        // add info
        this.userDetail = new UserDetail(this, registerDTO);
        // add role
        this.userAuthorities = new ArrayList<>();
        this.userAuthorities.add(new UserAuthority(this, authority));
    }

    public User(SocialLoginDTO socialLoginDTO, Authority authority, SocialNetwork socialNetwork) {
        this(socialLoginDTO, authority);
        this.setAvatar(socialLoginDTO.getAvatar());
        // add social network
        this.userSocialNetworks = new ArrayList<>();
        this.userSocialNetworks.add(new UserSocialNetwork(socialLoginDTO, this, socialNetwork));
    }
}
