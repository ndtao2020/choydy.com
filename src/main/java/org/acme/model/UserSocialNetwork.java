package org.acme.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
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
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@Table(uniqueConstraints = @UniqueConstraint(columnNames = {User.PATH_ID, "social_network_id"}))
public class UserSocialNetwork extends BaseId<UUID> {

    @Transient
    public static final String PATH = "userSocialNetwork";

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "social_network_id", nullable = false)
    private SocialNetwork socialNetwork;

    @Column(nullable = false)
    private String uid;

    @Column(nullable = false)
    private String email;

    private String phoneNumber;

    private String avatar;

    public UserSocialNetwork(SocialLoginDTO socialLoginDTO, User user, SocialNetwork socialNetwork) {
        this.user = user;
        this.socialNetwork = socialNetwork;
        this.uid = socialLoginDTO.getId();
        this.email = socialLoginDTO.getEmail();
        this.phoneNumber = socialLoginDTO.getPhoneNumber();
        this.avatar = socialLoginDTO.getAvatar();
    }
}
