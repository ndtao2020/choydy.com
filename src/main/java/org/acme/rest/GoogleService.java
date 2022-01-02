package org.acme.rest;

import org.acme.base.dto.GoogleDTO;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;

@Path("/")
@RegisterRestClient
public interface GoogleService {

    @GET
    @Path("/tokeninfo")
    GoogleDTO checkGoogleToken(@QueryParam("id_token") String token);
}
