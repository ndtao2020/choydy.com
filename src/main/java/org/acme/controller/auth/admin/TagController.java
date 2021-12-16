package org.acme.controller.auth.admin;

import org.acme.base.BaseController;
import org.acme.base.QueryPage;
import org.acme.constants.SecurityPath;
import org.acme.model.Tag;
import org.acme.service.TagService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

@Path(SecurityPath.ADMIN_API_URL + "/" + Tag.PATH)
public class TagController extends BaseController {

    @Inject
    TagService tagService;

    @GET
    @Produces("application/json")
    public QueryPage findAllPost(@QueryParam(PAGE_PARAM) Integer p, @QueryParam(SIZE_PARAM) Integer s, @QueryParam(SEARCH_PARAM) String search) {
        return tagService.searchDTOAndPagination(p == null ? PAGE_DEFAULT : p, s == null ? SIZE_DEFAULT : s, search, ID, "tag");
    }
}
