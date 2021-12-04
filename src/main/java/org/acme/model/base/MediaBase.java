package org.acme.model.base;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import java.util.UUID;

@Getter
@Setter
@MappedSuperclass
@NoArgsConstructor
public abstract class MediaBase extends BaseId<UUID> {

    @Column(nullable = false)
    private String type;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String link;

    public MediaBase(MediaBase mediaBase) {
        super(mediaBase.getId());
        this.type = mediaBase.getType();
        this.link = mediaBase.getLink();
    }
}
