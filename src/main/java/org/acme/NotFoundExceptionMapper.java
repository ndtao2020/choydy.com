package org.acme;

import javax.ws.rs.NotFoundException;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;
import java.io.InputStream;

@Provider
public class NotFoundExceptionMapper implements ExceptionMapper<NotFoundException> {
    @Override
    public Response toResponse(NotFoundException e) {
        final InputStream resourceAsStream = NotFoundExceptionMapper.class.getResourceAsStream("/META-INF/resources/index.html");
        return Response
                .ok(resourceAsStream)
                .header(HttpHeaders.CACHE_CONTROL, "public,immutable,max-age=1800")
                .header(HttpHeaders.CONTENT_TYPE, "text/html; charset=utf-8")
                .build();
    }
}
