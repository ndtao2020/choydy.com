package org.acme.controller;

import org.acme.base.BaseController;
import org.acme.constants.SecurityPath;
import org.acme.model.Comment;
import org.acme.model.Post;
import org.acme.model.Tag;
import org.acme.model.dto.CommentDTO;
import org.acme.model.dto.PostDTO;
import org.acme.service.CommentService;
import org.acme.service.LikeTypeService;
import org.acme.service.PostLikeService;
import org.acme.service.PostService;
import org.acme.service.TagService;

import javax.inject.Inject;
import javax.ws.rs.BadRequestException;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import java.sql.SQLDataException;
import java.util.List;
import java.util.UUID;

@Path(SecurityPath.PUBLIC_API_URL + "/" + Post.PATH)
public class PostController extends BaseController {

    @Inject
    PostService postService;

    @Inject
    TagService tagService;

    @Inject
    LikeTypeService likeTypeService;

    @Inject
    PostLikeService postLikeService;

    @Inject
    CommentService commentService;

    // ========================= [POST] =========================
    @GET
    @Produces("application/json")
    public List<?> findAllPost(@QueryParam(PAGE_PARAM) Integer p, @QueryParam(SIZE_PARAM) Integer s, @QueryParam(SEARCH_PARAM) String search) {
        return postService.search(p == null ? PAGE_DEFAULT : p, s == null ? SIZE_DEFAULT : s, search);
    }

    @GET
    @Path("/" + ID)
    @Produces("application/json")
    public PostDTO postId(@QueryParam(ID) UUID postId) {
        PostDTO postDTO = postService.findDTOById(postId);
        if (postDTO == null) {
            throw new BadRequestException("The post id does not exist !");
        }
        return postDTO;
    }

    // ========================= [LIKES] =========================
    @GET
    @Path("/like")
    @Produces("application/json")
    public List<?> getAllByPostId(@QueryParam(ID) UUID postId) throws BadRequestException {
        return postLikeService.findByPostId(postId);
    }

    @GET
    @Path("/like/type")
    @Produces("application/json")
    public List<?> getAllTypes() {
        return likeTypeService.findAll();
    }

    // ========================= [TAGS] =========================
    @GET
    @Path("/" + Tag.PATH)
    @Produces("application/json")
    public List<?> findAllByPostId(@QueryParam(ID) UUID postId) throws SQLDataException {
        return tagService.findAllByPostId(postId);
    }

    // ========================= [COMMENTS] =========================
    @GET
    @Path("/" + Comment.PATH)
    @Produces("application/json")
    public List<?> findAll(@QueryParam(ID) UUID postId, @QueryParam(PAGE_PARAM) Integer p, @QueryParam(SIZE_PARAM) Integer s) {
        return commentService.findByCommentId(postId, p == null ? PAGE_DEFAULT : p, s == null ? SIZE_DEFAULT : s);
    }

    @GET
    @Path("/" + Comment.PATH + "/" + ID)
    @Produces("application/json")
    public CommentDTO commentId(@QueryParam(ID) UUID commentId) {
        CommentDTO commentDTO = commentService.findDTOById(commentId);
        if (commentDTO == null) {
            throw new BadRequestException("The post id does not exist !");
        }
        return commentDTO;
    }
}
