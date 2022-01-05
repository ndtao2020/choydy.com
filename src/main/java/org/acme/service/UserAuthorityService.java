package org.acme.service;

import org.acme.model.Authority;
import org.acme.model.User;
import org.acme.model.UserAuthority;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class UserAuthorityService {

    @Inject
    EntityManager em;

    public List<?> findByUserId(UUID id) {
        return em
                .createNativeQuery("select " + Authority.PATH_ID + " from " + UserAuthority.PATH + " where " + User.PATH_ID + "=?1")
                .setParameter(1, id)
                .getResultList();
    }
}
