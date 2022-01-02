package org.acme.rest;

import org.acme.base.dto.GoogleDTO;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;
import org.jboss.resteasy.annotations.jaxrs.PathParam;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;

@Path("/")
@RegisterRestClient
public interface FacebookService {

    @GET
    @Path("/{id}/accounts")
    GoogleDTO checkFacebookToken(@PathParam String id, @QueryParam("access_token") String token);
}
