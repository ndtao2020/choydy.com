package org.acme.service;

import org.acme.base.dto.SocialLoginDTO;
import org.acme.base.service.BaseService;
import org.acme.model.User;
import org.acme.model.UserSocialNetwork;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.transaction.Transactional;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class UserSocialNetworkService extends BaseService<UserSocialNetwork, UserSocialNetwork, UUID> {

    @Inject
    SocialNetworkService socialNetworkService;

    protected UserSocialNetworkService() {
        super(UserSocialNetwork.class, UserSocialNetwork.class);
    }

    @Override
    public UserSocialNetwork convertToDTO(UserSocialNetwork data) {
        return data;
    }

    public List<?> findByUserId(UUID userId) {
        return getEm()
                .createNativeQuery("SELECT social_network_id,avatar,email,phonenumber from " + UserSocialNetwork.PATH + " where user_id=?1")
                .setParameter(1, userId)
                .getResultList();
    }

    public List<?> findByEmail(String email) {
        return getEm()
                .createNativeQuery("SELECT social_network_id,CAST (user_id AS varchar) from " + UserSocialNetwork.PATH + " where email=?1")
                .setParameter(1, email)
                .getResultList();
    }

    @Transactional
    public void create(SocialLoginDTO dto, User user) {
        UserSocialNetwork userSocialNetwork = new UserSocialNetwork(dto);
        userSocialNetwork.setUser(user);
        userSocialNetwork.setSocialNetwork(socialNetworkService.getByName(dto.getSocial()));
        this.save(userSocialNetwork);
    }
}
