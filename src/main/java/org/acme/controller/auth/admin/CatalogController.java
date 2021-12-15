package org.acme.controller.auth.admin;

import org.acme.base.BaseController;
import org.acme.base.dto.CheckDTO;
import org.acme.constants.SecurityPath;
import org.acme.model.Catalog;
import org.acme.model.dto.CatalogDTO;
import org.acme.service.CatalogService;
import org.jboss.logging.Logger;

import javax.inject.Inject;
import javax.ws.rs.DELETE;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

@Path(SecurityPath.ADMIN_API_URL + "/" + Catalog.PATH)
public class CatalogController extends BaseController {

    private static final Logger logger = Logger.getLogger(CatalogController.class);

    @Inject
    CatalogService catalogService;

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public CatalogDTO create(CatalogDTO data) throws IllegalAccessException {
        try {
            Catalog catalog = catalogService.save(new Catalog(data));
            return catalogService.convertToDTO(catalog);
        } catch (Exception e) {
            throw new IllegalAccessException(e.getMessage());
        }
    }

    @PUT
    @Produces(MediaType.APPLICATION_JSON)
    public CatalogDTO update(CatalogDTO data) throws IllegalAccessException {
        try {
            Catalog catalog = catalogService.update(new Catalog(data));
            CatalogDTO catalogDTO = catalogService.convertToDTO(catalog);
            catalogService.saveDTOById(catalog.getId(), catalogDTO);
            return catalogDTO;
        } catch (Exception e) {
            throw new IllegalAccessException(e.getMessage());
        }
    }

    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    public CheckDTO delete(@QueryParam(ID) Long id) throws IllegalAccessException {
        try {
            catalogService.delete(new Catalog(id));
            catalogService.deleteDTOById(id);
            return new CheckDTO(true);
        } catch (Exception e) {
            logger.error(e.getMessage());
            return new CheckDTO(false);
        }
    }
}
