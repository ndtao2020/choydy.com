package org.acme.service;

import org.acme.model.Post;
import org.acme.model.PostLike;
import org.acme.model.User;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class PostLikeService {

    @Inject
    EntityManager em;
    @Inject
    PostService postService;

    public List<?> findByPostId(UUID postId) {
        return em.createNativeQuery("select " + User.PATH_ID + ",type,created from " + PostLike.PATH + " where " + Post.PATH_ID + "=?1")
                .setParameter(1, postId)
                .getResultList();
    }

    public List<?> findByPostIdAndUserId(UUID postId, UUID userId) {
        return em
                .createNativeQuery("select type,created from " + PostLike.PATH + " where " + Post.PATH_ID + "=?1 and " + User.PATH_ID + "=?2")
                .setParameter(1, postId)
                .setParameter(2, userId)
                .getResultList();
    }

    @Transactional
    public void save(Long created, String type, UUID postId, UUID userId) throws SQLException {
        em.createNativeQuery("INSERT INTO " + PostLike.PATH + " (created," + User.PATH_ID + "," + Post.PATH_ID + ",type) VALUES(?1,?2,?3,?4)")
                .setParameter(1, created)
                .setParameter(2, userId)
                .setParameter(3, postId)
                .setParameter(4, type)
                .executeUpdate();
        postService.updateLike(postId, 1L);
    }

    @Transactional
    public void update(Long created, String type, UUID postId, UUID userId) throws SQLException {
        em.createNativeQuery("UPDATE " + PostLike.PATH + " SET created=?1,type=?2 WHERE " + Post.PATH_ID + "=?3 AND " + User.PATH_ID + "=?4")
                .setParameter(1, created)
                .setParameter(2, type)
                .setParameter(3, postId)
                .setParameter(4, userId)
                .executeUpdate();
    }

    @Transactional
    public void delete(UUID postId, UUID userId) throws SQLException {
        em.createNativeQuery("DELETE FROM " + PostLike.PATH + " WHERE " + Post.PATH_ID + "=?1 AND " + User.PATH_ID + "=?2")
                .setParameter(1, postId)
                .setParameter(2, userId)
                .executeUpdate();
        postService.updateLike(postId, -1L);
    }
}
