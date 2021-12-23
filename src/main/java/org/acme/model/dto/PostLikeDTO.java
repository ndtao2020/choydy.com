package org.acme.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.PostLike;
import org.acme.model.base.PostLikeBase;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
public class PostLikeDTO extends PostLikeBase {

    private UUID postId;
    private UUID userId;
    private String likeTypeId;

    public PostLikeDTO(PostLike postLike) {
        super(postLike);
    }
}
