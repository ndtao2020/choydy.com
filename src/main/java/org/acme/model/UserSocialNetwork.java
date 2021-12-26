package org.acme.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.acme.base.BaseId;
import org.acme.base.dto.SocialLoginDTO;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;
import java.util.UUID;

@Entity
@Table(uniqueConstraints = @UniqueConstraint(columnNames = {User.PATH_ID, SocialNetwork.PATH_ID}))
public class UserSocialNetwork extends BaseId<UUID> {

    @Transient
    public static final String PATH = "userSocialNetwork";

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = User.PATH_ID, nullable = false)
    private User user;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = SocialNetwork.PATH_ID, nullable = false)
    private SocialNetwork socialNetwork;

    @Column(nullable = false)
    private String uid;

    @Column(nullable = false)
    private String email;

    private String phoneNumber;

    private String avatar;

    public UserSocialNetwork() {
    }

    public UserSocialNetwork(SocialLoginDTO socialLoginDTO, User user, SocialNetwork socialNetwork) {
        this.user = user;
        this.socialNetwork = socialNetwork;
        this.uid = socialLoginDTO.getId();
        this.email = socialLoginDTO.getEmail();
        this.phoneNumber = socialLoginDTO.getPhoneNumber();
        this.avatar = socialLoginDTO.getAvatar();
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public SocialNetwork getSocialNetwork() {
        return socialNetwork;
    }

    public void setSocialNetwork(SocialNetwork socialNetwork) {
        this.socialNetwork = socialNetwork;
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

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}
