package org.acme.controller;

import org.acme.base.BaseController;
import org.acme.constants.SecurityPath;
import org.acme.model.Catalog;
import org.acme.model.dto.CatalogDTO;
import org.acme.service.CatalogService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import java.util.List;

@Path(SecurityPath.PUBLIC_API_URL + "/" + Catalog.PATH)
public class CatalogController extends BaseController {

    @Inject
    CatalogService catalogService;

    @GET
    @Path("/" + ID)
    @Produces("application/json")
    public CatalogDTO postId(@QueryParam(ID) Long id) {
        return catalogService.findDTOById(id);
    }

    @GET
    @Produces("application/json")
    public List<?> findAllPost(@QueryParam(PAGE_PARAM) Integer p, @QueryParam(SIZE_PARAM) Integer s, @QueryParam(SEARCH_PARAM) String search) {
        return catalogService.search(p == null ? PAGE_DEFAULT : p, s == null ? SIZE_DEFAULT : s, search);
    }
}
