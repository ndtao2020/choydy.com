package org.acme;

import javax.ws.rs.NotFoundException;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.nio.charset.StandardCharsets;

@Provider
public class NotFoundExceptionMapper implements ExceptionMapper<NotFoundException> {
    @Override
    public Response toResponse(NotFoundException e) {
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
