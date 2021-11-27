package org.acme.service;

import org.acme.model.Language;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;

@ApplicationScoped
public class LanguageService {

    @Inject
    EntityManager em;

    public Language getById(String id) {
        return em.find(Language.class, id);
    }
}
