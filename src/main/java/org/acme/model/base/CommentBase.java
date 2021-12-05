package org.acme.model.base;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import java.sql.Timestamp;
import java.util.UUID;

@Getter
@Setter
@MappedSuperclass
@NoArgsConstructor
public abstract class CommentBase extends BaseId<UUID> {

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;

    @Column(nullable = false)
    private Timestamp created;

    private Long likes = 0L;

    public CommentBase(CommentBase commentBase) {
        this.content = commentBase.getContent();
        this.created = commentBase.getCreated();
        this.likes = commentBase.getLikes();
    }
}
