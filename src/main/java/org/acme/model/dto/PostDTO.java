package org.acme.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.Tag;
import org.acme.model.base.PostBase;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
public class PostDTO extends PostBase {

    private UUID userId;
    private Long catalogId;

    // child
    private List<Tag> tags;

    public PostDTO(PostBase postBase) {
        super(postBase);
    }
}
