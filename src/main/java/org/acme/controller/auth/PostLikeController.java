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
import javax.ws.rs.BadRequestException;
import javax.ws.rs.DELETE;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;
import java.util.UUID;

@Path(SecurityPath.AUTH_API_URL + "/" + PostLike.PATH)
public class PostLikeController extends BaseController {

    private static final Logger logger = Logger.getLogger(PostLikeController.class);

    @Inject
    PostLikeService postLikeService;

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public PostLikeDTO createLikeByPostId(@Context SecurityContext context, @QueryParam(ID) UUID postId, @QueryParam("type") String likeTypeId) throws BadRequestException {
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
    public CheckDTO removeLikeByPostId(@Context SecurityContext context, @QueryParam(ID) UUID postId) throws BadRequestException {
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