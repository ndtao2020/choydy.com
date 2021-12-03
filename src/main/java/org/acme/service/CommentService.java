package org.acme.service;

import org.acme.base.service.BaseCacheService;
import org.acme.model.Comment;
import org.acme.model.Post;
import org.acme.model.dto.CommentDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.Query;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class CommentService extends BaseCacheService<Comment, CommentDTO, UUID> {

    protected CommentService() {
        super(Comment.class, CommentDTO.class, Comment.PATH);
    }

    @Override
    public CommentDTO convertToDTO(Comment data) {
        CommentDTO commentDTO = new CommentDTO(data);
        commentDTO.setPostId(data.getPost().getId());
        commentDTO.setUserId(data.getUser().getId());
        // Comment
        Comment comment = data.getParent();
        if (comment != null) {
            commentDTO.setParentId(comment.getId());
        }
        return commentDTO;
    }

    public List<?> findByCommentId(UUID commentId, int page, int size) {
        Query query = getEm().createNativeQuery("select CAST (id AS varchar) from comment where " + Post.PATH_ID + "=?1 order by created asc");
        query.setParameter(1, commentId);
        return query.setFirstResult(page * size).setMaxResults(size).getResultList();
    }
}
