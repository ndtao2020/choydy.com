package org.acme.model.base;

import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import java.util.UUID;

@MappedSuperclass
public abstract class CommentBase extends BaseId<UUID> {

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;

    @Column(nullable = false)
    private Long created;

    private Long likes = 0L;

    public CommentBase() {
    }

    public CommentBase(CommentBase commentBase) {
        this.content = commentBase.getContent();
        this.created = commentBase.getCreated();
        this.likes = commentBase.getLikes();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getCreated() {
        return created;
    }

    public void setCreated(Long created) {
        this.created = created;
    }

    public Long getLikes() {
        return likes;
    }

    public void setLikes(Long likes) {
        this.likes = likes;
    }
}
