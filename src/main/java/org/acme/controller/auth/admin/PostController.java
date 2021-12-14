package org.acme.controller.auth.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.acme.base.BaseController;
import org.acme.base.auth.JwtPrincipal;
import org.acme.constants.SecurityPath;
import org.acme.model.Post;
import org.acme.model.dto.PostDTO;
import org.acme.model.dto.PostMultipartDTO;
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
    @Produces(MediaType.APPLICATION_JSON)
    public PostDTO sendMultipartData(@Context SecurityContext context, @MultipartForm PostMultipartDTO data) throws IllegalAccessException {
        if (data.getFileType() == null || data.getFileName() == null || data.getData() == null || data.getFile() == null) {
            throw new NullPointerException("Misinformation !");
        }
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        try {
            return postService.create(
                    principal.getId(),
                    mapper.readValue(data.getData(), PostDTO.class),
                    data.getFileType(),
                    data.getFileName(),
                    data.getFile()
            );
        } catch (Exception e) {
            throw new IllegalAccessException(e.getMessage());
        }
    }
}
