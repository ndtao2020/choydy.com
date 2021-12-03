package org.acme.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.base.PostBase;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
public class PostDTO extends PostBase {
    private UUID userId;

    public PostDTO(PostBase postBase, UUID userId) {
        super(postBase);
        this.userId = userId;
    }
}
