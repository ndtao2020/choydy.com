package org.acme.controller.auth.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.acme.base.BaseController;
import org.acme.base.FileStorageService;
import org.acme.base.QueryPage;
import org.acme.base.UpdateList;
import org.acme.base.auth.JwtPrincipal;
import org.acme.base.dto.CheckDTO;
import org.acme.constants.SecurityPath;
import org.acme.model.Post;
import org.acme.model.PostTag;
import org.acme.model.dto.PostDTO;
import org.acme.model.dto.PostMultipartDTO;
import org.acme.service.PostService;
import org.acme.service.PostTagService;
import org.jboss.logging.Logger;
import org.jboss.resteasy.annotations.providers.multipart.MultipartForm;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Path(SecurityPath.ADMIN_API_URL + "/" + Post.PATH)
public class PostController extends BaseController {

    private static final Logger logger = Logger.getLogger(PostController.class);

    @Inject
    ObjectMapper mapper;
    @Inject
    PostService postService;
    @Inject
    PostTagService postTagService;

    @GET
    @Produces("application/json")
    public QueryPage findAllPost(@QueryParam(PAGE_PARAM) Integer p, @QueryParam(SIZE_PARAM) Integer s, @QueryParam(SEARCH_PARAM) String search) {
        return postService.searchDTOAndPagination(p == null ? PAGE_DEFAULT : p, s == null ? SIZE_DEFAULT : s, search, "created", "title", "content");
    }

    // ========================= [POST] =========================
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public PostDTO createPost(@Context SecurityContext context, @MultipartForm PostMultipartDTO data) throws IllegalAccessException {
        if (data.getFileType() == null || data.getFileName() == null || data.getData() == null || data.getFile() == null) {
            throw new NullPointerException("Misinformation !");
        }
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        try {
            PostDTO postDTO = mapper.readValue(data.getData(), PostDTO.class);
            if (data.getFileType() == null || postDTO.getCatalogId() == null || postDTO.getTags() == null) {
                throw new NullPointerException("Catalog Id and tags must not null !");
            }
            if (FileStorageService.VIDEO_TYPES.contains(data.getFileType()) && data.getThumbnail() == null) {
                throw new NullPointerException("The thumbnail must not null !");
            }
            return postService.create(principal.getId(), postDTO, data.getFileType(), data.getFileName(), data.getFile(), data.getThumbnail());
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new IllegalAccessException(e.getMessage());
        }
    }

    @PUT
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public PostDTO updatePost(@Context SecurityContext context, @MultipartForm PostMultipartDTO data) throws IllegalAccessException {
        try {
            PostDTO postDTO = mapper.readValue(data.getData(), PostDTO.class);
            // find by id
            Post post = postService.getById(postDTO.getId());
            if (post == null) {
                throw new SQLException("The post id does not exist !");
            }
            List<PostTag> postTags = postTagService.getByPostId(postDTO.getId());
            // find all to insert
            List<String> inserts = new ArrayList<>();
            for (Object tagDTO : postDTO.getTags()) {
                String tagDTOId = tagDTO.toString();
                // check
                boolean has = false;
                for (PostTag postTag : postTags) {
                    if (postTag.getTag().equals(tagDTOId)) {
                        has = true;
                        break;
                    }
                }
                // if not exist when add to insert
                if (!has) {
                    inserts.add(tagDTOId);
                }
            }
            // find all to remove
            List<String> removes = new ArrayList<>();
            for (PostTag postTag : postTags) {
                String tag = postTag.getTag();
                // check
                boolean has = false;
                for (Object tagDTO : postDTO.getTags()) {
                    String tagDTOId = tagDTO.toString();
                    if (tag.equals(tagDTOId)) {
                        has = true;
                        break;
                    }
                }
                // if not exist when add to remove
                if (!has) {
                    removes.add(tag);
                }
            }
            // update
            post.setTitle(postDTO.getTitle());
            post.setContent(postDTO.getContent());
            // update
            return postService.update(post, postDTO.getCatalogId(), new UpdateList<>(inserts, removes), data.getFileType(), data.getFileName(), data.getFile(), data.getThumbnail());
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new IllegalAccessException(e.getMessage());
        }
    }

    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    public CheckDTO delete(@QueryParam(ID_PARAM) UUID postId) {
        try {
            postService.remove(postId);
            return new CheckDTO(true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return new CheckDTO(false);
        }
    }
}
