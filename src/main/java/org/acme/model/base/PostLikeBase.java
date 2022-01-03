package org.acme.model.base;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import java.io.Serial;
import java.io.Serializable;

@MappedSuperclass
public abstract class PostLikeBase implements Serializable {

    @Serial
    private static final long serialVersionUID = -5L;

    @Column(nullable = false)
    private Long created;

    @Column(nullable = false)
    private String type;

    public PostLikeBase() {
    }

    public PostLikeBase(PostLikeBase postLikeBase) {
        this.created = postLikeBase.getCreated();
        this.type = postLikeBase.getType();
    }

    public Long getCreated() {
        return created;
    }

    public void setCreated(Long created) {
        this.created = created;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
