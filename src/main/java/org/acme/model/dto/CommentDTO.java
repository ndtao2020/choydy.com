package org.acme.model.dto;

import org.acme.model.base.CommentBase;

import java.util.UUID;

public class CommentDTO extends CommentBase {

    private UUID postId;
    private UUID userId;
    private UUID parentId;

    public CommentDTO() {
    }

    public CommentDTO(CommentBase commentBase) {
        super(commentBase);
    }

    public UUID getPostId() {
        return postId;
    }

    public void setPostId(UUID postId) {
        this.postId = postId;
    }

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    public UUID getParentId() {
        return parentId;
    }

    public void setParentId(UUID parentId) {
        this.parentId = parentId;
    }
}
