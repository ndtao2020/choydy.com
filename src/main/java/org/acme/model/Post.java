package org.acme.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
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
@Table(indexes = {@Index(columnList = "created"), @Index(columnList = User.PATH_ID), @Index(columnList = "title,content")})
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

    public Post() {
    }

    public Post(UUID id) {
        super(id);
    }

    public Post(PostBase postBase) {
        super(postBase);
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Catalog getCatalog() {
        return catalog;
    }

    public void setCatalog(Catalog catalog) {
        this.catalog = catalog;
    }

    public List<Media> getMedia() {
        return media;
    }

    public void setMedia(List<Media> media) {
        this.media = media;
    }
}
