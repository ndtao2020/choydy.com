package org.acme.controller.auth;

import org.acme.base.BaseController;
import org.acme.base.auth.JwtPrincipal;
import org.acme.base.dto.CheckDTO;
import org.acme.constants.SecurityPath;
import org.acme.model.PostLike;
import org.acme.model.dto.PostLikeDTO;
import org.acme.service.PostLikeService;
import org.jboss.logging.Logger;

import javax.inject.Inject;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;
import java.sql.SQLException;
import java.util.UUID;

@Path(SecurityPath.AUTH_API_URL + "/" + PostLike.PATH)
public class PostLikeController extends BaseController {

    private static final Logger logger = Logger.getLogger(PostLikeController.class);

    @Inject
    PostLikeService postLikeService;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Boolean checkLike(@Context SecurityContext context, @QueryParam(ID_PARAM) UUID postId) throws SQLException {
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        return postLikeService.findByPostIdAndUserId(postId, principal.getId());
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public PostLikeDTO createLike(@Context SecurityContext context, @QueryParam(ID_PARAM) UUID postId, @QueryParam("t") String likeTypeId) throws SQLException {
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        // create post
        PostLikeDTO postLikeDTO = new PostLikeDTO();
        postLikeDTO.setCreated(System.currentTimeMillis());
        postLikeDTO.setUserId(principal.getId());
        postLikeDTO.setPostId(postId);
        postLikeDTO.setLikeTypeId(likeTypeId);
        postLikeService.save(postLikeDTO);
        return postLikeDTO;
    }

    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    public CheckDTO removeLike(@Context SecurityContext context, @QueryParam(ID_PARAM) UUID postId) {
        try {
            JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
            postLikeService.delete(postId, principal.getId());
            return new CheckDTO(true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return new CheckDTO(false);
        }
    }
}
