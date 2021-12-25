package org.acme.service;

import org.acme.model.LikeType;
import org.acme.model.Post;
import org.acme.model.PostLike;
import org.acme.model.User;
import org.acme.model.dto.PostLikeDTO;

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
        return em.createNativeQuery("select " + User.PATH_ID + "," + LikeType.PATH_ID + ",created from " + PostLike.PATH + " where " + Post.PATH_ID + "=?1")
                .setParameter(1, postId)
                .getResultList();
    }

    @Transactional
    public void save(PostLikeDTO postLikeDTO) throws SQLException {
        em.createNativeQuery("INSERT INTO " + PostLike.PATH + " (created," + User.PATH_ID + "," + Post.PATH_ID + "," + LikeType.PATH_ID + ") VALUES(?1,?2,?3,?4)")
                .setParameter(1, postLikeDTO.getCreated())
                .setParameter(2, postLikeDTO.getUserId())
                .setParameter(3, postLikeDTO.getPostId())
                .setParameter(4, postLikeDTO.getLikeTypeId())
                .executeUpdate();
        postService.updateLike(postLikeDTO.getPostId(), 1L);
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
