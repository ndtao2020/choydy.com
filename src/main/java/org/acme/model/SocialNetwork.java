package org.acme.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.acme.model.base.SocialNetworkBase;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.List;

@Entity
@Table
@Data
@EqualsAndHashCode(callSuper = true)
public class SocialNetwork extends SocialNetworkBase {

    private String clientId;

    private String clientSecret;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "socialNetwork")
    private List<UserSocialNetwork> userSocialNetworks;
}
