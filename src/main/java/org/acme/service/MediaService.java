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

    public String findCacheById(String id) throws SQLDataException {
        String data = fetchCache(id);
        if (data == null) {
            UUID uuid = UUID.fromString(id);
            Object media = getEm()
                    .createNativeQuery("select link from " + getTableName(getDomainClass()) + " where id=?1")
                    .setParameter(1, uuid)
                    .getSingleResult();
            if (media == null) {
                throw new SQLDataException("Data does not exist with id !");
            }
            return this.saveObjectById(uuid, media.toString(), true).toString();
        }
        return data;
    }

    public List<?> findByPostId(String postId) throws SQLDataException {
        PostDTO postDTO = postService.customFindDTOById(postId);
        if (postDTO == null) {
            throw new SQLDataException("Post id does not exist !");
        }
        List<?> list = postDTO.getMedia();
        if (list == null) {
            try {
                UUID uuid = UUID.fromString(postId);
                List<?> media = getEm()
                        .createNativeQuery("select CAST (id AS varchar),type from " + getTableName(getDomainClass()) + " where " + Post.PATH_ID + "=?1")
                        .setParameter(1, uuid)
                        .getResultList();
                if (media == null) {
                    throw new SQLDataException("Data does not exist with Post id !");
                }
                // set new cache
                postDTO.setMedia(media);
                postService.updateDTOById(uuid, postDTO);
                // return
                return media;
            } catch (Exception e) {
                getLog().error(e.getMessage());
            }
        }
        return list;
    }
}
