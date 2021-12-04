package org.acme.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.base.MediaBase;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
public class MediaDTO extends MediaBase {

    private UUID postId;

    public MediaDTO(MediaBase mediaBase, UUID postId) {
        super(mediaBase);
        this.postId = postId;
    }
}
