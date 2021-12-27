package org.acme.service;

import org.acme.base.service.BaseCacheService;
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
public class MediaService extends BaseCacheService<Media, MediaDTO, UUID> {

    @Inject
    PostService postService;

    protected MediaService() {
        super(Media.class, MediaDTO.class, Media.PATH, 2592000L);
    }

    @Override
    public MediaDTO convertToDTO(Media data) {
        return new MediaDTO(data);
    }

    public String findCacheById(UUID id) throws SQLDataException {
        String data = fetchCache(id.toString());
        if (data == null) {
            Object media = getEm()
                    .createNativeQuery("select link from " + getTableName(getDomainClass()) + " where id=?1")
                    .setParameter(1, id)
                    .getSingleResult();
            if (media == null) {
                throw new SQLDataException("Data does not exist with id !");
            }
            return this.saveObjectById(id, media.toString(), true).toString();
        }
        return data;
    }

    public List<?> findByPostId(UUID postId) throws SQLDataException {
        PostDTO postDTO = postService.findDTOById(postId);
        if (postDTO == null) {
            throw new SQLDataException("Post id does not exist !");
        }
        List<?> list = postDTO.getMedia();
        if (list == null) {
            List<?> media = getEm()
                    .createNativeQuery("select CAST (id AS varchar),type from " + getTableName(getDomainClass()) + " where " + Post.PATH_ID + "=?1")
                    .setParameter(1, postId)
                    .getResultList();
            if (media == null) {
                throw new SQLDataException("Data does not exist with Post id !");
            }
            // set new cache
            postDTO.setMedia(media);
            try {
                postService.updateDTOById(postId, postDTO);
            } catch (Exception e) {
                getLog().error(e.getMessage());
            }
            // return
            return media;
        }
        return list;
    }
}
