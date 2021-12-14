package org.acme.service;

import org.acme.base.service.BaseCacheService;
import org.acme.model.Catalog;
import org.acme.model.Media;
import org.acme.model.Post;
import org.acme.model.User;
import org.acme.model.dto.PostDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.Query;
import javax.transaction.Transactional;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class PostService extends BaseCacheService<Post, PostDTO, UUID> {

    @Inject
    MinIOStorageService minIOStorageService;
    @Inject
    MediaService mediaService;

    protected PostService() {
        super(Post.class, PostDTO.class, Post.PATH);
    }

    @Override
    public PostDTO convertToDTO(Post data) {
        PostDTO postDTO = new PostDTO(data);
        postDTO.setUserId(data.getUser().getId());
        postDTO.setCatalogId(data.getCatalog().getId());
        return postDTO;
    }

    public List<?> search(int page, int size, String search) {
        String q = "from post ";
        if (search != null) {
            q += "where title like :s or content like :s ";
        }
        Query query = getEm().createNativeQuery("select CAST (id AS varchar) " + q + "order by created desc");
        if (search != null) {
            query.setParameter("s", "%" + search + "%");
        }
        return query.setFirstResult(page * size).setMaxResults(size).getResultList();
    }

    @Transactional
    public PostDTO create(UUID userId, PostDTO postDTO, String fileType, String fileName, InputStream file) throws IOException {
        Post post = new Post(postDTO);
        post.setUser(new User(userId));
        post.setCatalog(new Catalog(postDTO.getCatalogId()));
        // ======================================= phù phép
        post.setCount(5000L);
        post.setLikes(2000L);
        post.setShares(10L);
        // ======================================= phù phép
        // save file
        Media media = new Media();
        media.setPost(post);
        media.setType(fileType);
        media.setLink("/");
        // add to post
        List<Media> mediaList = new ArrayList<>();
        mediaList.add(media);
        // add to post
        post.setMedia(mediaList);
        // insert to DB
        Post savedPost = this.save(post);
        for (Media media1 : savedPost.getMedia()) {
            String mediaId = media1.getId().toString();
            // if images
            if ("image/jpeg".equals(fileType)) {
                media1.setLink(minIOStorageService.uploadImage(Post.PATH, mediaId, fileType, fileName, file));
            }
            // if videos
            if ("video/mp4".equals(fileType)) {
                media1.setLink(minIOStorageService.uploadVideo(Post.PATH, mediaId, fileType, fileName, file));
            }
            mediaService.update(media1);
        }
        return convertToDTO(savedPost);
    }
}
