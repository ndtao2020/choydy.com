package org.acme.model.dto;

import org.acme.model.PostLike;
import org.acme.model.base.PostLikeBase;

import java.util.UUID;

public class PostLikeDTO extends PostLikeBase {

    private UUID postId;
    private UUID userId;

    public PostLikeDTO() {
    }

    public PostLikeDTO(PostLike postLike) {
        super(postLike);
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
}
