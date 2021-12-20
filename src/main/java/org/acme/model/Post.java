package org.acme.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.base.PostBase;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
@Table(indexes = {@Index(columnList = "created"), @Index(columnList = User.PATH_ID), @Index(columnList = "title,content")})
@NoArgsConstructor
public class Post extends PostBase {

    @Transient
    public static final String PATH = "post";
    @Transient
    public static final String PATH_ID = "post_id";

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false)
    private User user;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false)
    private Catalog catalog;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = Post.PATH)
    private List<Media> media;

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = Post.PATH)
    private List<PostTag> postTags;

    public Post(UUID id) {
        super(id);
    }

    public Post(PostBase postBase) {
        super(postBase);
    }
}
