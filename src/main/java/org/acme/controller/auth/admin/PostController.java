package org.acme.controller.auth.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.acme.base.BaseController;
import org.acme.base.auth.JwtPrincipal;
import org.acme.constants.SecurityPath;
import org.acme.model.Post;
import org.acme.model.Tag;
import org.acme.model.dto.PostDTO;
import org.acme.model.dto.PostMultipartDTO;
import org.acme.service.PostService;
import org.acme.service.TagService;
import org.jboss.resteasy.annotations.providers.multipart.MultipartForm;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;
import java.util.ArrayList;
import java.util.List;

@Path(SecurityPath.ADMIN_API_URL + "/" + Post.PATH)
public class PostController extends BaseController {

    @Inject
    ObjectMapper mapper;
    @Inject
    PostService postService;
    @Inject
    TagService tagService;

    // ========================= [POST] =========================
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    @Produces(MediaType.APPLICATION_JSON)
    public PostDTO sendMultipartData(@Context SecurityContext context, @MultipartForm PostMultipartDTO data) throws IllegalAccessException {
        if (data.getFileType() == null || data.getFileName() == null || data.getData() == null || data.getFile() == null) {
            throw new NullPointerException("Misinformation !");
        }
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        try {
            PostDTO postDTO = mapper.readValue(data.getData(), PostDTO.class);
            if (postDTO.getCatalogId() == null || postDTO.getTags() == null) {
                throw new NullPointerException("Misinformation !");
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
            throw new IllegalAccessException(e.getMessage());
        }
    }
}
