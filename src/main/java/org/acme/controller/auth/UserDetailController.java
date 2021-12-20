package org.acme.controller.auth;

import org.acme.base.BaseController;
import org.acme.base.auth.JwtPrincipal;
import org.acme.base.dto.CheckDTO;
import org.acme.constants.SecurityPath;
import org.acme.model.Country;
import org.acme.model.UserDetail;
import org.acme.model.base.UserDetailBase;
import org.acme.model.dto.UserDetailDTO;
import org.acme.service.CountryService;
import org.acme.service.UserDetailService;

import javax.inject.Inject;
import javax.ws.rs.BadRequestException;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.SecurityContext;
import java.sql.SQLDataException;

@Path(SecurityPath.AUTH_API_URL + "/" + UserDetailBase.PATH)
public class UserDetailController extends BaseController {

    @Inject
    CountryService countryService;

    @Inject
    UserDetailService userDetailService;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public UserDetailDTO get(@Context SecurityContext context) throws SQLDataException {
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        return userDetailService.findByUserId(principal.getId());
    }

    @PUT
    @Produces(MediaType.APPLICATION_JSON)
    public CheckDTO update(@Context SecurityContext context, UserDetailDTO userDetailDTO) {
        if (userDetailDTO.getCountryIso() == null) {
            throw new BadRequestException("Country id must not null !");
        }
        Country country = countryService.getById(userDetailDTO.getCountryIso());
        if (country == null) {
            throw new BadRequestException("Country id does not exist !");
        }
        JwtPrincipal principal = (JwtPrincipal) context.getUserPrincipal();
        UserDetail userDetail = userDetailService.getByUserId(principal.getId());
        userDetail.update(userDetailDTO);
        userDetail.setCountry(country);
        try {
            // update cache
            userDetailService.updateCache(principal.getId(), userDetailService.update(userDetail));
            return new CheckDTO(true);
        } catch (Exception e) {
            return new CheckDTO(false);
        }
    }
}
