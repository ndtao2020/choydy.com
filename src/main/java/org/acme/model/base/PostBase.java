package org.acme.model.base;

import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.NotNull;
import java.util.UUID;

@MappedSuperclass
public abstract class PostBase extends BaseId<UUID> {

    @Column(nullable = false)
    private Long created;

    @NotNull(message = "Title cannot be null")
    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String content;

    private Long count = 0L;
    private Long shares = 0L;

    @Column(nullable = false)
    private Boolean disable;

    public PostBase() {
    }

    public PostBase(UUID id) {
        super(id);
    }

    public PostBase(PostBase postBase) {
        super(postBase.getId());
        this.created = postBase.getCreated();
        this.title = postBase.getTitle();
        this.content = postBase.getContent();
        this.count = postBase.getCount();
        this.shares = postBase.getShares();
        this.disable = postBase.getDisable();
    }

    public Long getCreated() {
        return created;
    }

    public void setCreated(Long created) {
        this.created = created;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public Long getShares() {
        return shares;
    }

    public void setShares(Long shares) {
        this.shares = shares;
    }

    public Boolean getDisable() {
        return disable;
    }

    public void setDisable(Boolean disable) {
        this.disable = disable;
    }
}
