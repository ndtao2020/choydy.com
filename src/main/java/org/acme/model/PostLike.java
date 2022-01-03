package org.acme.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.acme.model.base.PostLikeBase;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.io.Serial;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table
public class PostLike extends PostLikeBase implements Serializable {

    @Transient
    public static final String PATH = "postlike";
    @Serial
    private static final long serialVersionUID = 65L;
    @Id
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false)
    private Post post;

    @Id
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false)
    private User user;

    public PostLike() {
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PostLike postLike = (PostLike) o;
        return post.equals(postLike.post) && user.equals(postLike.user);
    }

    @Override
    public int hashCode() {
        return Objects.hash(post, user);
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
