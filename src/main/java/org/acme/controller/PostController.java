package org.acme.controller;

import org.acme.base.BaseController;
import org.acme.constants.SecurityPath;
import org.acme.model.Comment;
import org.acme.model.Media;
import org.acme.model.Post;
import org.acme.model.dto.CommentDTO;
import org.acme.service.CommentService;
import org.acme.service.MediaService;
import org.acme.service.PostLikeService;
import org.acme.service.PostService;
import org.acme.service.PostTagService;
import org.eclipse.microprofile.config.ConfigProvider;

import javax.inject.Inject;
import javax.ws.rs.BadRequestException;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
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
    PostLikeService postLikeService;
    @Inject
    CommentService commentService;

    private final int maxSize;

    public PostController() {
        Integer size = ConfigProvider.getConfig().getValue("vue.app.max.size.fetch", Integer.class);
        maxSize = size == null ? 3 : size;
    }

    // ========================= [POST] =========================
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> findAllPost(@QueryParam(PAGE_PARAM) Integer page, @QueryParam(SEARCH_PARAM) String search, @QueryParam("c") Long catalogId) {
        if (catalogId == null) {
            return postService.search(page == null ? PAGE_DEFAULT : page, maxSize, search);
        }
        return postService.search(page == null ? PAGE_DEFAULT : page, maxSize, catalogId, search);
    }

    @GET
    @Path("/" + ID)
    @Produces(MediaType.APPLICATION_JSON)
    public Object postId(@QueryParam(ID_PARAM) String postId) throws SQLDataException {
        return postService.customFindObjectById(postId);
    }

    @POST
    @Path("/view")
    public void updateView(@QueryParam(ID_PARAM) UUID postId) {
        postService.updateView(postId);
    }

    @POST
    @Path("/share")
    public void updateShare(@QueryParam(ID_PARAM) UUID postId) {
        postService.updateShare(postId);
    }

    // ========================= [TAGS] =========================
    @GET
    @Path("/tag")
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> findAllTagByPostId(@QueryParam(ID_PARAM) String postId) throws SQLDataException {
        return postTagService.findByPostId(postId);
    }

    // ========================= [MEDIA] =========================
    @GET
    @Path("/" + Media.PATH)
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> findAllMediaByPostId(@QueryParam(ID_PARAM) String postId) throws SQLDataException {
        return mediaService.findByPostId(postId);
    }

    // ========================= [LIKES] =========================
    @GET
    @Path("/like")
    @Produces(MediaType.APPLICATION_JSON)
    public Object getStatisticByPostId(@QueryParam(ID_PARAM) String postId) throws BadRequestException {
        return postLikeService.statisticByPostId(postId);
    }

    @GET
    @Path("/like/all")
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> getAllByPostId(@QueryParam(ID_PARAM) UUID postId) throws BadRequestException {
        return postLikeService.findByPostId(postId);
    }

    // ========================= [COMMENTS] =========================
    @GET
    @Path("/" + Comment.PATH)
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> findAll(@QueryParam(ID_PARAM) UUID postId, @QueryParam(PAGE_PARAM) Integer p, @QueryParam(SIZE_PARAM) Integer s) {
        return commentService.findByPostId(postId, p == null ? PAGE_DEFAULT : p, s == null ? SIZE_DEFAULT : s);
    }

    @GET
    @Path("/" + Comment.PATH + "/" + ID)
    @Produces(MediaType.APPLICATION_JSON)
    public CommentDTO commentId(@QueryParam(ID_PARAM) UUID commentId) {
        CommentDTO commentDTO = commentService.findDTOById(commentId);
        if (commentDTO == null) {
            throw new BadRequestException("The post id does not exist !");
        }
        return commentDTO;
    }
}
