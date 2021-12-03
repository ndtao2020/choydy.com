package org.acme.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.base.CommentBase;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
public class CommentDTO extends CommentBase {

    private UUID postId;
    private UUID userId;
    private UUID parentId;

    public CommentDTO(CommentBase commentBase) {
        super(commentBase);
    }
}
