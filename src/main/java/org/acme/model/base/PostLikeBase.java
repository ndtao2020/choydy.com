package org.acme.model.base;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public abstract class PostLikeBase {

    @Column(nullable = false)
    private Long created;

    public PostLikeBase() {
    }

    public PostLikeBase(PostLikeBase postLikeBase) {
        this.created = postLikeBase.getCreated();
    }

    public Long getCreated() {
        return created;
    }

    public void setCreated(Long created) {
        this.created = created;
    }
}
