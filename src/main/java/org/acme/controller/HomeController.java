package org.acme.controller;

import org.acme.NotFoundExceptionMapper;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.nio.charset.StandardCharsets;

@Path("/")
public class HomeController {

    @GET
    public Response home() {
        final InputStream indexIS = NotFoundExceptionMapper.class.getResourceAsStream("/META-INF/index.html");
        if (indexIS == null) {
            return Response.temporaryRedirect(URI.create("/")).build();
        }
        final InputStreamReader inputStream = new InputStreamReader(indexIS, StandardCharsets.UTF_8);
        return Response
                .ok(inputStream)
                .header("cache-control", "max-age=1800")
                .header("content-type", "text/html; charset=utf-8")
                .build();
    }
}
