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

@ApplicationScoped
public class AuthorityService {

    @Inject
    EntityManager em;

    public AuthorityDTO convertToDTO(Authority authority) {
        return new AuthorityDTO(authority);
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
