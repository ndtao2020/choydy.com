package org.acme.controller;

import org.acme.base.BaseController;
import org.acme.constants.SecurityPath;
import org.acme.model.Comment;
import org.acme.model.Media;
import org.acme.model.Post;
import org.acme.model.dto.CommentDTO;
import org.acme.model.dto.PostDTO;
import org.acme.service.CommentService;
import org.acme.service.LikeTypeService;
import org.acme.service.MediaService;
import org.acme.service.PostLikeService;
import org.acme.service.PostService;
import org.acme.service.PostTagService;

import javax.inject.Inject;
import javax.ws.rs.BadRequestException;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import java.sql.SQLDataException;
import java.util.List;
import java.util.UUID;

@Path(SecurityPath.PUBLIC_API_URL + "/" + Post.PATH)
public class PostController extends BaseController {

    @Inject
    PostService postService;
    @Inject
    PostTagService postTagService;
    @Inject
    MediaService mediaService;
    @Inject
    LikeTypeService likeTypeService;
    @Inject
    PostLikeService postLikeService;
    @Inject
    CommentService commentService;

    // ========================= [POST] =========================
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> findAllPost(@QueryParam(PAGE_PARAM) Integer p, @QueryParam(SIZE_PARAM) Integer s, @QueryParam(SEARCH_PARAM) String search) {
        return postService.search(p == null ? PAGE_DEFAULT : p, s == null ? SIZE_DEFAULT : s, search);
    }

    @GET
    @Path("/" + ID)
    @Produces(MediaType.APPLICATION_JSON)
    public PostDTO postId(@QueryParam(ID) UUID postId) {
        PostDTO postDTO = postService.findDTOById(postId);
        if (postDTO == null) {
            throw new BadRequestException("The post id does not exist !");
        }
        return postDTO;
    }

    // ========================= [TAGS] =========================
    @GET
    @Path("/tag")
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> findAllTagByPostId(@QueryParam(ID) UUID postId) throws SQLDataException {
        return postTagService.findByPostId(postId);
    }

    // ========================= [MEDIA] =========================
    @GET
    @Path("/" + Media.PATH)
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> findAllMediaByPostId(@QueryParam(ID) UUID postId) throws SQLDataException {
        return mediaService.findByPostId(postId);
    }

    // ========================= [LIKES] =========================
    @GET
    @Path("/like/type")
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> getAllTypes() {
        return likeTypeService.findAll();
    }

    @GET
    @Path("/like")
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> getAllByPostId(@QueryParam(ID) UUID postId) throws BadRequestException {
        return postLikeService.findByPostId(postId);
    }

    // ========================= [COMMENTS] =========================
    @GET
    @Path("/" + Comment.PATH)
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> findAll(@QueryParam(ID) UUID postId, @QueryParam(PAGE_PARAM) Integer p, @QueryParam(SIZE_PARAM) Integer s) {
        return commentService.findByCommentId(postId, p == null ? PAGE_DEFAULT : p, s == null ? SIZE_DEFAULT : s);
    }

    @GET
    @Path("/" + Comment.PATH + "/" + ID)
    @Produces(MediaType.APPLICATION_JSON)
    public CommentDTO commentId(@QueryParam(ID) UUID commentId) {
        CommentDTO commentDTO = commentService.findDTOById(commentId);
        if (commentDTO == null) {
            throw new BadRequestException("The post id does not exist !");
        }
        return commentDTO;
    }
}
