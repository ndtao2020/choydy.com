package org.acme;

import javax.ws.rs.NotFoundException;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class NotFoundExceptionMapper implements ExceptionMapper<NotFoundException> {
    @Override
    public Response toResponse(NotFoundException e) {
        return HomeRoute.responseBuilder(
                NotFoundExceptionMapper.class
                        .getResourceAsStream(HomeRoute.TEMPLATE_DIR)
        );
    }
}
