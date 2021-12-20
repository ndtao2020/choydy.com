package org.acme;

import javax.ws.rs.NotFoundException;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class NotFoundExceptionMapper implements ExceptionMapper<NotFoundException> {
    @Override
    public Response toResponse(NotFoundException e) {
        return Response
                .ok(NotFoundExceptionMapper.class.getResourceAsStream("/META-INF/resources/index.html"))
                .header(HttpHeaders.CACHE_CONTROL, "max-age=1800")
                .header(HttpHeaders.CONTENT_TYPE, "text/html; charset=utf-8")
                .build();
    }
}
