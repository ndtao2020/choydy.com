package org.acme.controller.auth;

import org.acme.base.BaseController;
import org.acme.base.dto.CheckDTO;
import org.acme.constants.SecurityPath;
import org.acme.controller.OAuthController;
import org.acme.model.Tag;
import org.acme.service.TagService;
import org.jboss.logging.Logger;

import javax.inject.Inject;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path(SecurityPath.AUTH_API_URL + "/" + Tag.PATH)
public class TagController extends BaseController {

    private static final Logger logger = Logger.getLogger(OAuthController.class);

    @Inject
    TagService tagService;

    @GET
    @Produces("application/json")
    public List<?> search(@QueryParam(PAGE_PARAM) Integer p, @QueryParam(SIZE_PARAM) Integer s, @QueryParam(SEARCH_PARAM) String search) {
        return tagService.search(p == null ? PAGE_DEFAULT : p, s == null ? SIZE_DEFAULT : s, search, ID, "tag");
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Tag create(Tag data) throws IllegalAccessException {
        try {
            return tagService.save(data);
        } catch (Exception e) {
            throw new IllegalAccessException(e.getMessage());
        }
    }

    @PUT
    @Produces(MediaType.APPLICATION_JSON)
    public Tag update(Tag data) throws IllegalAccessException {
        try {
            Tag tag = tagService.convertToDTO(tagService.update(data));
            tagService.saveDTOById(tag.getId(), tag);
            return tag;
        } catch (Exception e) {
            throw new IllegalAccessException(e.getMessage());
        }
    }

    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    public CheckDTO delete(@QueryParam(ID) String id) throws IllegalAccessException {
        try {
            tagService.delete(new Tag(id));
            tagService.deleteDTOById(id);
            return new CheckDTO(true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return new CheckDTO(false);
        }
    }
}
