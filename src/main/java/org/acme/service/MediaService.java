package org.acme.service;

import org.acme.base.service.BaseService;
import org.acme.model.Media;
import org.acme.model.Post;
import org.acme.model.dto.MediaDTO;
import org.acme.model.dto.PostDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.sql.SQLDataException;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class MediaService extends BaseService<Media, MediaDTO, UUID> {

    @Inject
    PostService postService;

    protected MediaService() {
        super(Media.class, MediaDTO.class);
    }

    @Override
    public MediaDTO convertToDTO(Media data) {
        MediaDTO mediaDTO = new MediaDTO();
        mediaDTO.setPostId(data.getPost().getId());
        return mediaDTO;
    }

    public List<?> findAllByPostId(UUID postId) throws SQLDataException {
        PostDTO postDTO = postService.findDTOById(postId);
        if (postDTO == null) {
            throw new SQLDataException("Post id does not exist !");
        }
        List<?> list = postDTO.getMedia();
        if (list == null) {
            List<?> media = getEm()
                    .createNativeQuery("select link,type from " + getTableName(getDomainClass()) + " where " + Post.PATH_ID + "=?1")
                    .setParameter(1, postId)
                    .getResultList();
            if (media == null) {
                throw new SQLDataException("Data does not exist with Post id !");
            }
            // set new cache
            postDTO.setMedia(media);
            try {
                postService.saveDTOById(postId, postDTO);
            } catch (Exception e) {
                getLog().error(e.getMessage());
            }
            // return
            return media;
        }
        return list;
    }
}
