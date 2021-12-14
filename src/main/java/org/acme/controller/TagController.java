package org.acme.controller;

import org.acme.base.BaseController;
import org.acme.constants.SecurityPath;
import org.acme.model.Tag;
import org.acme.service.TagService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import java.util.List;

@Path(SecurityPath.PUBLIC_API_URL + "/" + Tag.PATH)
public class TagController extends BaseController {

    @Inject
    TagService tagService;

    @GET
    @Path("/" + ID)
    @Produces("application/json")
    public Tag postId(@QueryParam(ID) String id) {
        return tagService.findDTOById(id);
    }

    @GET
    @Produces("application/json")
    public List<?> findAllPost(@QueryParam(PAGE_PARAM) Integer p, @QueryParam(SIZE_PARAM) Integer s, @QueryParam(SEARCH_PARAM) String search) {
        return tagService.search(p == null ? PAGE_DEFAULT : p, s == null ? SIZE_DEFAULT : s, search);
    }
}
