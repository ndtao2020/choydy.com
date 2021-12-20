package org.acme.model.base;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.NotNull;
import java.util.UUID;

@Getter
@Setter
@MappedSuperclass
@NoArgsConstructor
public abstract class PostBase extends BaseId<UUID> {

    @Column(nullable = false)
    private Long created;

    @NotNull(message = "Title cannot be null")
    @Column(nullable = false)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String content;

    private Long count = 0L;
    private Long likes = 0L;
    private Long shares = 0L;
    private Long comments = 0L;

    @Column(nullable = false)
    private Boolean disable;

    public PostBase(UUID id) {
        super(id);
    }

    public PostBase(PostBase postBase) {
        super(postBase.getId());
        this.created = postBase.getCreated();
        this.title = postBase.getTitle();
        this.content = postBase.getContent();
        this.count = postBase.getCount();
        this.likes = postBase.getLikes();
        this.shares = postBase.getShares();
        this.comments = postBase.getComments();
        this.disable = postBase.getDisable();
    }
}
