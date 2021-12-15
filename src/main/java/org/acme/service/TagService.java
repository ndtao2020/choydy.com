package org.acme.service;

import org.acme.base.service.BaseCacheService;
import org.acme.model.Post;
import org.acme.model.PostTag;
import org.acme.model.Tag;
import org.acme.model.dto.PostDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.sql.SQLDataException;
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

    public List<?> findAllByPostId(UUID postId) throws SQLDataException {
        PostDTO postDTO = postService.findDTOById(postId);
        if (postDTO == null) {
            throw new SQLDataException("Post id does not exist !");
        }
        List<?> list = postDTO.getTags();
        if (list == null) {
            List<?> tags = getEm()
                    .createNativeQuery("select " + Tag.PATH_ID + " from " + getTableName(PostTag.class) + " where " + Post.PATH_ID + "=?1")
                    .setParameter(1, postId)
                    .getResultList();
            if (tags == null) {
                throw new SQLDataException("Data does not exist with Post id !");
            }
            // set new cache
            postDTO.setTags(tags);
            try {
                postService.saveDTOById(postId, postDTO);
            } catch (Exception e) {
                getLog().error(e.getMessage());
            }
            // return
            return tags;
        }
        return list;
    }
}
