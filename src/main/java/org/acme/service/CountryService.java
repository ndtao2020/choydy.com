package org.acme.service;

import org.acme.model.Authority;
import org.acme.model.Country;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import java.util.List;

@ApplicationScoped
public class CountryService {

    @Inject
    EntityManager em;

    public Country getById(String id) {
        return em.find(Country.class, id);
    }

    public List<Authority> getAll() {
        return em
                .createQuery("from " + Country.class.getPackageName() + "." + Country.class.getSimpleName(), Authority.class)
                .getResultList();
    }
}
