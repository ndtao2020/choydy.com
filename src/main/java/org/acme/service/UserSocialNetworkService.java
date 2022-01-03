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

    public List<UserSocialNetwork> findByUserId(UUID userId) {
        return getEm()
                .createQuery("from " + getNameEntity(getDomainClass()) + " where user.id=?1", getDomainClass())
                .setParameter(1, userId)
                .getResultList();
    }

    public List<UserSocialNetwork> findByEmail(String email) {
        return getEm()
                .createQuery("from " + getNameEntity(getDomainClass()) + " where email=?1", getDomainClass())
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
