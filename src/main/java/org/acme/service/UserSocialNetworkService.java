package org.acme.service;

import org.acme.base.dto.SocialLoginDTO;
import org.acme.model.User;
import org.acme.model.UserSocialNetwork;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class UserSocialNetworkService {

    @Inject
    EntityManager em;

    public List<?> findByUserId(UUID userId) {
        return em
                .createNativeQuery("SELECT social,avatar,email,phonenumber from " + UserSocialNetwork.PATH + " where " + User.PATH_ID + "=?1")
                .setParameter(1, userId)
                .getResultList();
    }

    public List<?> findByEmail(String email) {
        return em
                .createNativeQuery("SELECT CAST (" + User.PATH_ID + " AS varchar),social from " + UserSocialNetwork.PATH + " where email=?1")
                .setParameter(1, email)
                .getResultList();
    }

    @Transactional
    public User create(SocialLoginDTO dto, UUID userId) {
        em.createNativeQuery("INSERT INTO " + UserSocialNetwork.PATH + " (email,phonenumber,uid,social," + User.PATH_ID + ") VALUES(:email,:phonenumber,:uid,:social,:user_id)")
                .setParameter("email", dto.getEmail())
                .setParameter("phonenumber", dto.getPhoneNumber())
                .setParameter("uid", dto.getId())
                .setParameter("social", dto.getSocial().name())
                .setParameter("user_id", userId)
                .executeUpdate();
        return new User(userId, true);
    }
}
