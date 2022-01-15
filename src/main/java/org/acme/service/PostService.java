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
import java.sql.SQLDataException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

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
        super(Post.class, PostDTO.class, Post.PATH, 604800L);
    }

    @Override
    public PostDTO convertToDTO(Post data) {
        PostDTO postDTO = new PostDTO(data);
        postDTO.setUserId(data.getUser().getId());
        postDTO.setCatalogId(data.getCatalog().getId());
        return postDTO;
    }

    public PostDTO customFindDTOById(String id) throws SQLDataException {
        PostDTO dto = fetchFromCache(id);
        if (dto == null) {
            try {
                UUID uuid = UUID.fromString(id);
                Post data = super.getById(uuid);
                return data == null ? null : this.saveDTOById(uuid, this.convertToDTO(data));
            } catch (Exception e) {
                throw new SQLDataException(e.getMessage());
            }
        }
        return dto;
    }

    public Object customFindObjectById(String id) throws SQLDataException {
        Object dto = fetchCache(id);
        if (dto == null) {
            try {
                UUID uuid = UUID.fromString(id);
                Post data = super.getById(uuid);
                return data == null ? null : this.saveDTOById(uuid, this.convertToDTO(data));
            } catch (Exception e) {
                throw new SQLDataException(e.getMessage());
            }
        }
        return dto;
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

    public List<?> search(int page, int size, long catalogId, String search) {
        String q = "from post where catalog_id=:c ";
        if (search != null) {
            q += "and title like :s or content like :s ";
        }
        Query query = getEm().createNativeQuery("select CAST (id AS varchar) " + q + "order by created desc");
        query.setParameter("c", catalogId);
        if (search != null) {
            query.setParameter("s", "%" + search + "%");
        }
        return query.setFirstResult(page * size).setMaxResults(size).getResultList();
    }

    public List<?> getAllRecommend(UUID postId) {
        return getEm().createNativeQuery("select CAST (id AS varchar) from post where id not in (?1) order by random()")
                .setParameter(1, postId)
                .setMaxResults(6)
                .getResultList();
    }

    public QueryPage searchDTOAndPagination(int page, int size, String search, String order, String... fields) {
        List<PostDTO> result = new ArrayList<>();
        for (Object obj : search(page, size, search, order, fields)) {
            result.add(this.findDTOById(UUID.fromString(obj.toString())));
        }
        return new QueryPage(result, getCountQuery(search, fields).getSingleResult());
    }

    @Transactional
    public void updateView(UUID postId) {
        try {
            // find by id
            Post post = this.getById(postId);
            post.setCount(post.getCount() + 1);
            // update SQL
            Post savedPost = this.update(post);
            // update cache
            PostDTO postDTO = this.findDTOById(postId);
            if (postDTO == null) {
                this.saveDTOById(postId, this.convertToDTO(savedPost));
            } else {
                postDTO.setCount(savedPost.getCount());
                this.updateDTOById(postId, postDTO);
            }
        } catch (Exception e) {
            this.getLog().error(e.getMessage());
        }
    }

    @Transactional
    public void updateShare(UUID postId) {
        try {
            // find by id
            Post post = this.getById(postId);
            post.setShares(post.getShares() + 1);
            // update SQL
            Post savedPost = this.update(post);
            // update cache
            PostDTO postDTO = this.findDTOById(postId);
            if (postDTO == null) {
                this.saveDTOById(postId, this.convertToDTO(savedPost));
            } else {
                postDTO.setShares(savedPost.getShares());
                this.updateDTOById(postId, postDTO);
            }
        } catch (Exception e) {
            this.getLog().error(e.getMessage());
        }
    }

    @Transactional
    public PostDTO create(UUID userId, PostDTO postDTO, String fileType, String fileName, InputStream file, InputStream thumbnail) throws SQLException {
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
        post.setCount(0L);
        post.setShares(0L);
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
                if (thumbnail == null) {
                    throw new NullPointerException("The thumbnail must not null !");
                }
                media1.setLink(fileStorageService.uploadVideo(Post.PATH, mediaId, fileName, file, thumbnail));
            }
            mediaService.update(media1);
        }
        return convertToDTO(savedPost);
    }

    @Transactional
    public PostDTO update(Post post, Long catalogId, UpdateList<String> TagList, String fileType, String fileName, InputStream file, InputStream thumbnail) throws SQLException {
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
                    if (thumbnail == null) {
                        throw new NullPointerException("The thumbnail must not null !");
                    }
                    media.setLink(fileStorageService.uploadVideo(Post.PATH, mediaId, fileName, file, thumbnail));
                }
                mediaService.update(media);
            }
        }
        PostDTO postDTO = this.convertToDTO(savedPost);
        try {
            return this.updateDTOById(post.getId(), this.convertToDTO(savedPost));
        } catch (Exception e) {
            getLog().error(e.getMessage());
            return postDTO;
        }
    }

    @Transactional
    public void remove(UUID postId) throws SQLException {
        // find by id
        Post post = this.getById(postId);
        if (post == null) {
            throw new SQLException("The post id does not exist !");
        }
        // delete all children
        getEm()
                .createNativeQuery("DELETE FROM \"" + Comment.PATH + "\" WHERE " + Post.PATH_ID + "=?1")
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
        // remove file
        for (Media media : post.getMedia()) {
            fileStorageService.deleteFile(media.getLink());
            mediaService.deleteDTOById(media.getId());
        }
        getEm()
                .createNativeQuery("DELETE FROM \"" + Media.PATH + "\" WHERE " + Post.PATH_ID + "=?1")
                .setParameter(1, postId)
                .executeUpdate();
        // delete
        getEm()
                .createNativeQuery("DELETE FROM \"" + Post.PATH + "\" WHERE id=?1")
                .setParameter(1, postId)
                .executeUpdate();
        // clear cache
        try {
            this.deleteDTOById(postId);
        } catch (Exception e) {
            getLog().error(e.getMessage());
        }
    }
}
