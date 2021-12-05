package org.acme.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.PostTag;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
public class PostTagDTO {

    private UUID postId;
    private String tagId;

    public PostTagDTO(PostTag postTag) {
        this.postId = postTag.getPost().getId();
        this.tagId = postTag.getTag().getId();
    }
}
