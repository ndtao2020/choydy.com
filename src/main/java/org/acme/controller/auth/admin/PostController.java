package org.acme.controller.auth.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.vertx.redis.client.Response;
import org.acme.base.BaseController;
import org.acme.base.auth.JwtPrincipal;
import org.acme.constants.SecurityPath;
import org.acme.model.Post;
import org.acme.model.dto.PostDTO;
import org.acme.model.dto.PostMultipartDTO;
import org.acme.service.CommentService;
import org.acme.service.LikeTypeService;
import org.acme.service.PostLikeService;
import org.acme.service.PostService;
import org.jboss.resteasy.annotations.providers.multipart.MultipartForm;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;

@Path(SecurityPath.ADMIN_API_URL + "/" + Post.PATH)
public class PostController extends BaseController {

    @Inject
    ObjectMapper mapper;

    @Inject
    PostService postService;

    // ========================= [POST] =========================
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.TEXT_PLAIN)
    public PostDTO sendMultipartData(@Context SecurityContext context, @MultipartForm PostMultipartDTO data) throws IllegalAccessException {
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        try {
            PostDTO postDTO = mapper.readValue(data.getPostData(), PostDTO.class);
            return postService.create(principal.getId(), postDTO, data.getFileName(), data.getFile());
        } catch (Exception e) {
            throw new IllegalAccessException(e.getMessage());
        }
    }
}
