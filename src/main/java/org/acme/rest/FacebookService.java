package org.acme.rest;

import org.acme.base.dto.FacebookDTO;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;

@Path("/v12.0")
@RegisterRestClient
public interface FacebookService {

    @GET
    @Path("/me")
    FacebookDTO checkFacebookToken(@QueryParam("fields") String fields, @QueryParam("access_token") String token);
}
