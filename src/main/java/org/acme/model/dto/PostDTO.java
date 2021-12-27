package org.acme.model.dto;

import org.acme.model.base.PostBase;

import java.util.List;
import java.util.UUID;

public class PostDTO extends PostBase {

    private UUID userId;
    private Long catalogId;

    // child
    private List<?> tags;
    private List<?> media;

    public PostDTO() {
    }

    public PostDTO(PostBase postBase) {
        super(postBase);
    }

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    public Long getCatalogId() {
        return catalogId;
    }

    public void setCatalogId(Long catalogId) {
        this.catalogId = catalogId;
    }

    public List<?> getTags() {
        return tags;
    }

    public void setTags(List<?> tags) {
        this.tags = tags;
    }

    public List<?> getMedia() {
        return media;
    }

    public void setMedia(List<?> media) {
        this.media = media;
    }
}
