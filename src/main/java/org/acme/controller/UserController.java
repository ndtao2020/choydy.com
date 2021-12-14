package org.acme.controller;

import org.acme.base.BaseController;
import org.acme.constants.SecurityPath;
import org.acme.model.User;
import org.acme.model.dto.UserDTO;
import org.acme.model.dto.UserShortDTO;
import org.acme.service.UserService;

import javax.inject.Inject;
import javax.ws.rs.BadRequestException;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
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
    public UserShortDTO getById(@QueryParam(ID) UUID id) throws BadRequestException {
        UserDTO userDTO = userService.findDTOById(id);
        if (userDTO == null) {
            throw new BadRequestException("Id does not exist !");
        }
        return new UserShortDTO(userDTO.getName(), userDTO.getAvatar());
    }
}
