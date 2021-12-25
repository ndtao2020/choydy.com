package org.acme.controller;

import org.acme.base.BaseController;
import org.acme.base.FileStorageService;
import org.acme.constants.SecurityPath;
import org.acme.model.Media;
import org.acme.service.MediaService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.sql.SQLDataException;
import java.util.UUID;

@Path(SecurityPath.PUBLIC_API_URL + "/" + Media.PATH)
public class MediaController extends BaseController {

    @Inject
    MediaService mediaService;
    @Inject
    FileStorageService fileStorageService;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getById(@QueryParam(ID_PARAM) UUID id, @QueryParam("t") String type) throws SQLDataException, IOException {
        return Response
                .ok(fileStorageService.getFile(mediaService.findCacheById(id)))
                .header(HttpHeaders.CACHE_CONTROL, "max-age=604800")
                .header(HttpHeaders.CONTENT_TYPE, type)
                .build();
    }
}
