package org.acme.service;

import org.acme.model.Post;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class PostLikeService {

    @Inject
    EntityManager em;

    public List<?> findByPostId(UUID postId) {
        return em.createNativeQuery("select * from postlike where " + Post.PATH_ID + "=?1")
                .setParameter(1, postId)
                .getResultList();
    }
}
