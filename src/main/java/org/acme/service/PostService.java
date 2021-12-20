package org.acme.service;

import org.acme.base.FileStorageService;
import org.acme.base.QueryPage;
import org.acme.base.UpdateList;
import org.acme.base.service.BaseCacheService;
import org.acme.model.Catalog;
import org.acme.model.Comment;
import org.acme.model.Media;
import org.acme.model.Post;
import org.acme.model.PostLike;
import org.acme.model.PostTag;
import org.acme.model.User;
import org.acme.model.dto.PostDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.Query;
import javax.transaction.Transactional;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ThreadLocalRandom;

@ApplicationScoped
public class PostService extends BaseCacheService<Post, PostDTO, UUID> {

    @Inject
    CatalogService catalogService;
    @Inject
    PostTagService postTagService;
    @Inject
    MediaService mediaService;
    @Inject
    FileStorageService fileStorageService;

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

    public QueryPage searchDTOAndPagination(int page, int size, String search, String order, String... fields) {
        List<PostDTO> result = new ArrayList<>();
        for (Object obj : search(page, size, search, order, fields)) {
            result.add(this.findDTOById(UUID.fromString(obj.toString())));
        }
        return new QueryPage(result, getCountQuery(search, fields).getSingleResult());
    }

    @Transactional
    public PostDTO create(UUID userId, PostDTO postDTO, String fileType, String fileName, InputStream file) throws SQLException {
        // validate
        if (!(FileStorageService.IMAGE_TYPES.contains(fileType) || FileStorageService.VIDEO_TYPES.contains(fileType))) {
            throw new SQLException("The file type does not support !");
        }
        Catalog catalog = catalogService.getById(postDTO.getCatalogId());
        if (catalog == null) {
            throw new SQLException("The catalog id does not exist !");
        }
        // init
        Post post = new Post(postDTO);
        post.setDisable(false);
        post.setCreated(System.currentTimeMillis());
        post.setUser(new User(userId));
        post.setCatalog(catalog);
        // ======================================= phù phép
        post.setCount(ThreadLocalRandom.current().nextLong(100, 10000));
        post.setLikes(ThreadLocalRandom.current().nextLong(100, 5000));
        post.setShares(ThreadLocalRandom.current().nextLong(10, 500));
        // ======================================= phù phép
        // ======================================= Media
        Media media = new Media();
        media.setPost(post);
        media.setType(fileType);
        media.setLink("/");
        // add to post
        List<Media> mediaList = new ArrayList<>();
        mediaList.add(media);
        // add to post
        post.setMedia(mediaList);
        // ========================================
        // insert to DB
        Post savedPost = this.save(post);
        // ======================================= Tag
        for (Object tag : postDTO.getTags()) {
            postTagService.save(savedPost.getId(), tag.toString());
        }
        // ======================================= Media
        for (Media media1 : savedPost.getMedia()) {
            String mediaId = media1.getId().toString();
            // if images
            if (FileStorageService.IMAGE_TYPES.contains(fileType)) {
                media1.setLink(fileStorageService.uploadImage(Post.PATH, mediaId, fileName, file));
            }
            // if videos
            if (FileStorageService.VIDEO_TYPES.contains(fileType)) {
                media1.setLink(fileStorageService.uploadVideo(Post.PATH, mediaId, fileName, file));
            }
            mediaService.update(media1);
        }
        return convertToDTO(savedPost);
    }

    @Transactional
    public PostDTO update(Post post, Long catalogId, UpdateList<String> TagList, String fileType, String fileName, InputStream file) throws SQLException {
        // validate
        Catalog catalog = catalogService.getById(catalogId);
        if (catalog == null) {
            throw new SQLException("The catalog id does not exist !");
        }
        // update
        post.setCatalog(catalog);
        // update
        Post savedPost = this.update(post);
        // ======================================= Tag
        for (String tag : TagList.getInserts()) {
            postTagService.save(post.getId(), tag);
        }
        for (String tag : TagList.getRemoves()) {
            postTagService.delete(post.getId(), tag);
        }
        // ======================================= Media
        if (fileType != null && fileName != null && file != null) {
            if (!(FileStorageService.IMAGE_TYPES.contains(fileType) || FileStorageService.VIDEO_TYPES.contains(fileType))) {
                throw new SQLException("The file type does not support !");
            }
            // ======================================= Media
            for (Media media : post.getMedia()) {
                media.setType(fileType);
                String mediaId = media.getId().toString();
                fileStorageService.deleteFile(media.getLink());
                // if image
                if (FileStorageService.IMAGE_TYPES.contains(fileType)) {
                    media.setLink(fileStorageService.uploadImage(Post.PATH, mediaId, fileName, file));
                }
                // if video
                if (FileStorageService.VIDEO_TYPES.contains(fileType)) {
                    media.setLink(fileStorageService.uploadVideo(Post.PATH, mediaId, fileName, file));
                }
                mediaService.update(media);
            }
        }
        return convertToDTO(savedPost);
    }

    @Transactional
    public void remove(UUID postId) {
        // delete all children
        getEm()
                .createNativeQuery("DELETE FROM \"" + Comment.PATH + "\" WHERE " + Post.PATH_ID + "=?1")
                .setParameter(1, postId)
                .executeUpdate();
        getEm()
                .createNativeQuery("DELETE FROM \"" + Media.PATH + "\" WHERE " + Post.PATH_ID + "=?1")
                .setParameter(1, postId)
                .executeUpdate();
        getEm()
                .createNativeQuery("DELETE FROM \"" + PostLike.PATH + "\" WHERE " + Post.PATH_ID + "=?1")
                .setParameter(1, postId)
                .executeUpdate();
        getEm()
                .createNativeQuery("DELETE FROM \"" + PostTag.PATH + "\" WHERE " + Post.PATH_ID + "=?1")
                .setParameter(1, postId)
                .executeUpdate();
        // delete
        getEm()
                .createNativeQuery("DELETE FROM \"" + Post.PATH + "\" WHERE id=?1")
                .setParameter(1, postId)
                .executeUpdate();
        // clear cache
        this.deleteDTOById(postId);
    }
}
