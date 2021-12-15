package org.acme.service;

import org.acme.base.service.BaseCacheService;
import org.acme.model.PostTag;
import org.acme.model.Tag;
import org.acme.model.dto.PostDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.sql.SQLDataException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class TagService extends BaseCacheService<Tag, Tag, String> {

    @Inject
    PostService postService;

    protected TagService() {
        super(Tag.class, Tag.class, Tag.PATH);
    }

    @Override
    public Tag convertToDTO(Tag data) {
        return data;
    }

    public List<Tag> findAllByPostId(UUID postId) throws SQLDataException {
        PostDTO postDTO = postService.findDTOById(postId);
        if (postDTO == null) {
            throw new SQLDataException("Post id does not exist !");
        }
        List<Tag> tagDTO = postDTO.getTags();
        if (tagDTO == null) {
            List<PostTag> postTags;
            try {
                postTags = getEm().createQuery("from " + getNameEntity(PostTag.class) + " where post.id=?1", PostTag.class)
                        .setParameter(1, postId)
                        .getResultList();
            } catch (Exception e) {
                postTags = null;
            }
            if (postTags == null) {
                throw new SQLDataException("Data does not exist with Post id !");
            }
            List<Tag> tags = new ArrayList<>();
            for (PostTag postTag : postTags) {
                tags.add(postTag.getTag());
            }
            // set new cache
            postDTO.setTags(tags);
            postService.saveDTOById(postId, postDTO);
            // return
            return tags;
        }
        return tagDTO;
    }
}
