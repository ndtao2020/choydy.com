package org.acme.model.base;

import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import java.util.UUID;

@MappedSuperclass
public abstract class MediaBase extends BaseId<UUID> {

    @Column(nullable = false)
    private String type;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String link;

    public MediaBase() {
    }

    public MediaBase(MediaBase mediaBase) {
        super(mediaBase.getId());
        this.type = mediaBase.getType();
        this.link = mediaBase.getLink();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }
}
