package org.acme.service;

import org.acme.model.Post;
import org.acme.model.PostTag;
import org.acme.model.dto.PostDTO;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.sql.SQLDataException;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class PostTagService {

    private static final Logger logger = Logger.getLogger(PostTagService.class);

    @Inject
    EntityManager em;
    @Inject
    PostService postService;

    @Transactional
    public void save(UUID postId, String tagId) {
        em.createNativeQuery("INSERT INTO " + PostTag.PATH + " (tag," + Post.PATH_ID + ") VALUES(?1,?2)")
                .setParameter(1, tagId)
                .setParameter(2, postId)
                .executeUpdate();
    }

    @Transactional
    public void delete(UUID postId, String tagId) {
        em.createNativeQuery("DELETE FROM " + PostTag.PATH + " WHERE tag=?1 AND " + Post.PATH_ID + "=?2")
                .setParameter(1, tagId)
                .setParameter(2, postId)
                .executeUpdate();
    }

    public List<PostTag> getByPostId(UUID postId) throws SQLDataException {
        return em.createQuery("from PostTag where post.id=?1", PostTag.class)
                .setParameter(1, postId)
                .getResultList();
    }

    public List<?> findByPostId(String postId) throws SQLDataException {
        PostDTO postDTO = postService.customFindDTOById(postId);
        if (postDTO == null) {
            throw new SQLDataException("Post id does not exist !");
        }
        List<?> list = postDTO.getTags();
        if (list == null) {
            try {
                UUID uuid = UUID.fromString(postId);
                List<?> tags = em.createNativeQuery("select tag from " + PostTag.PATH + " where " + Post.PATH_ID + "=?1")
                        .setParameter(1, uuid)
                        .getResultList();
                if (tags == null) {
                    throw new SQLDataException("Data does not exist with Post id !");
                }
                // set new cache
                postDTO.setTags(tags);
                postService.updateDTOById(uuid, postDTO);
                // return
                return tags;
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
        }
        return list;
    }
}
