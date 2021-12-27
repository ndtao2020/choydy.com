package org.acme.model.dto;

import org.acme.model.base.PostBase;

import java.util.List;
import java.util.UUID;

public class PostDTO extends PostBase {

    private String avatar;
    private String username;
    private Long catalogId;
    private String catalogName;

    // child
    private List<?> tags;
    private List<?> media;

    public PostDTO() {
    }

    public PostDTO(PostBase postBase) {
        super(postBase);
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Long getCatalogId() {
        return catalogId;
    }

    public void setCatalogId(Long catalogId) {
        this.catalogId = catalogId;
    }

    public String getCatalogName() {
        return catalogName;
    }

    public void setCatalogName(String catalogName) {
        this.catalogName = catalogName;
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
