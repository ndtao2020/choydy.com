package org.acme.controller.auth.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.acme.base.BaseController;
import org.acme.base.QueryPage;
import org.acme.base.auth.JwtPrincipal;
import org.acme.constants.SecurityPath;
import org.acme.model.Post;
import org.acme.model.Tag;
import org.acme.model.dto.PostDTO;
import org.acme.model.dto.PostMultipartDTO;
import org.acme.service.PostService;
import org.acme.service.TagService;
import org.jboss.logging.Logger;
import org.jboss.resteasy.annotations.providers.multipart.MultipartForm;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;
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
    TagService tagService;

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
            if (postDTO.getCatalogId() == null || postDTO.getTags() == null) {
                throw new NullPointerException("Catalog Id and tags must not null !");
            }
            List<Tag> tagList = new ArrayList<>();
            for (Object tagDTO : postDTO.getTags()) {
                Tag tag = tagService.getById(tagDTO.toString());
                if (tag == null) {
                    tag = tagService.create(tagDTO.toString());
                }
                tagList.add(tag);
            }
            return postService.create(principal.getId(), postDTO, tagList, data.getFileType(), data.getFileName(), data.getFile());
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new IllegalAccessException(e.getMessage());
        }
    }

    @PUT
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public PostDTO updatePost(@Context SecurityContext context, @MultipartForm PostMultipartDTO data, @QueryParam(ID) UUID postId) throws IllegalAccessException {
        if (data.getFileType() == null || data.getFileName() == null || data.getData() == null || data.getFile() == null) {
            throw new NullPointerException("Misinformation !");
        }
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        try {
            return null;
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new IllegalAccessException(e.getMessage());
        }
    }
}
