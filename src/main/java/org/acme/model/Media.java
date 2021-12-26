package org.acme.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.acme.model.base.MediaBase;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table
public class Media extends MediaBase {

    @Transient
    public static final String PATH = "media";
    @Transient
    public static final String PATH_ID = "media_id";

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false)
    private Post post;

    public Media() {
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }
}
