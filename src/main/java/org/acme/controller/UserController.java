package org.acme.controller;

import org.acme.base.BaseController;
import org.acme.constants.SecurityPath;
import org.acme.model.User;
import org.acme.service.UserService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import java.sql.SQLDataException;
import java.util.UUID;

@Path(SecurityPath.PUBLIC_API_URL + "/" + User.PATH)
public class UserController extends BaseController {

    @Inject
    UserService userService;

    /**
     * Get short information of account
     *
     * @param id of account
     * @return ResponseEntity
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Object getById(@QueryParam(ID_PARAM) UUID id) throws SQLDataException {
        return userService.getShortDetail(id);
    }
}
