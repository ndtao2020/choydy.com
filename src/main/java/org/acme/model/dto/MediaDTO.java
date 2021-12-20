package org.acme.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.base.MediaBase;

@Getter
@Setter
@NoArgsConstructor
public class MediaDTO extends MediaBase {
    public MediaDTO(MediaBase mediaBase) {
        super(mediaBase);
    }
}
