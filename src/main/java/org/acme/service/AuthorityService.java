package org.acme.service;

import org.acme.constants.Role;
import org.acme.model.Authority;
import org.acme.model.UserAuthority;
import org.acme.model.dto.AuthorityDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class AuthorityService {

    @Inject
    EntityManager em;

    public AuthorityDTO convertToDTO(Authority authority) {
        return new AuthorityDTO(authority);
    }

    public UUID generateId() {
        UUID uuid = UUID.randomUUID();
        List<?> data = em
                .createNativeQuery("select CAST (id AS varchar) from " + UserAuthority.PATH + " where id=?1")
                .setParameter(1, uuid)
                .getResultList();
        if (data != null && !data.isEmpty()) {
            return generateId();
        }
        return uuid;
    }

    public List<AuthorityDTO> convertToDTO(List<Authority> authorities) {
        List<AuthorityDTO> authorityDTOS = new ArrayList<>();
        for (Authority authority : authorities) {
            authorityDTOS.add(this.convertToDTO(authority));
        }
        return authorityDTOS;
    }

    public Authority getById(Role role) {
        return em.find(Authority.class, role);
    }

    public List<Authority> findAll() {
        return em.createQuery("from " + Authority.class.getPackageName() + "." + Authority.class.getSimpleName(), Authority.class)
                .getResultList();
    }

    @Transactional
    public UserAuthority save(UserAuthority userAuthority) {
        em.persist(userAuthority);
        return userAuthority;
    }
}
