package org.acme.model.base;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import java.sql.Timestamp;

@Getter
@Setter
@MappedSuperclass
@NoArgsConstructor
public abstract class PostLikeBase {

    @Column(nullable = false)
    private Timestamp created;

    public PostLikeBase(PostLikeBase postLikeBase) {
        this.created = postLikeBase.getCreated();
    }
}
