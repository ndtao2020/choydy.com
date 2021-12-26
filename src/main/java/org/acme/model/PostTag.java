package org.acme.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;
import java.io.Serial;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
@Table(uniqueConstraints = @UniqueConstraint(columnNames = {Post.PATH_ID, "tag"}))
public class PostTag implements Serializable {

    @Transient
    public static final String PATH = "posttag";
    @Serial
    private static final long serialVersionUID = 1234L;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false)
    private Post post;

    @Column(nullable = false)
    private String tag;

    public PostTag(Post post, String tag) {
        this.post = post;
        this.tag = tag;
    }

    public PostTag() {
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PostTag postTag = (PostTag) o;
        return post.equals(postTag.post) && tag.equals(postTag.tag);
    }

    @Override
    public int hashCode() {
        return Objects.hash(post, tag);
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }
}
