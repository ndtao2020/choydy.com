package org.acme.service;

import org.acme.model.LanguageTag;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;

@ApplicationScoped
public class LanguageTagService {

    @Inject
    EntityManager em;

    public LanguageTag getById(String id) {
        return em.find(LanguageTag.class, id);
    }
}
