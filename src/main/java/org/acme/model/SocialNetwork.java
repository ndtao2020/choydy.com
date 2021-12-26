package org.acme.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.acme.model.base.SocialNetworkBase;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

@Entity
@Table
public class SocialNetwork extends SocialNetworkBase {

    @Transient
    public static final String PATH_ID = "social_network_id";

    private String clientId;

    private String clientSecret;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "socialNetwork")
    private List<UserSocialNetwork> userSocialNetworks;

    public SocialNetwork() {
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getClientSecret() {
        return clientSecret;
    }

    public void setClientSecret(String clientSecret) {
        this.clientSecret = clientSecret;
    }

    public List<UserSocialNetwork> getUserSocialNetworks() {
        return userSocialNetworks;
    }

    public void setUserSocialNetworks(List<UserSocialNetwork> userSocialNetworks) {
        this.userSocialNetworks = userSocialNetworks;
    }
}
