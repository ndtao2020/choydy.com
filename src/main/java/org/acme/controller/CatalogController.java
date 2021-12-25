package org.acme.controller;

import org.acme.base.BaseController;
import org.acme.constants.SecurityPath;
import org.acme.model.Catalog;
import org.acme.service.CatalogService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path(SecurityPath.PUBLIC_API_URL + "/" + Catalog.PATH)
public class CatalogController extends BaseController {

    @Inject
    CatalogService catalogService;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<?> findAllPost(@QueryParam(PAGE_PARAM) Integer p, @QueryParam(SIZE_PARAM) Integer s) {
        return catalogService.search(p == null ? PAGE_DEFAULT : p, s == null ? SIZE_DEFAULT : s);
    }

    @GET
    @Path("/" + ID)
    @Produces(MediaType.APPLICATION_JSON)
    public Object catalogId(@QueryParam(ID_PARAM) Long catalogId) {
        return catalogService.findById(catalogId);
    }
}
