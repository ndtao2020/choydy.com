package org.acme.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(uniqueConstraints = @UniqueConstraint(columnNames = {Post.PATH_ID, "tag"}))
public class PostTag implements Serializable {

    @Transient
    public static final String PATH = "posttag";

    @Id
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false)
    private Post post;

    @Column(nullable = false)
    private String tag;

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
}
