package org.acme.routes;

import org.acme.model.Post;
import org.jboss.resteasy.annotations.jaxrs.PathParam;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

@Path("/" + Post.PATH)
public class PostRoute {

    public static final String TEMPLATE_DIR = "/META-INF/resources/index.html";

    @GET
    @Path("/{id}")
    public Response getOne(@PathParam String id) throws IOException {
        final InputStream resourceAsStream = PostRoute.class.getResourceAsStream(TEMPLATE_DIR);
        assert resourceAsStream != null;
        String text = new String(resourceAsStream.readAllBytes(), StandardCharsets.UTF_8);
        // substring
        String begin = text.substring(0, text.indexOf("<meta BF9415284D71D>"));
        String body = "<title>" + id + "</title>\n" +
                "<meta name=\"title\" content=\"" + id + "\" />\n" +
                "<meta name=\"description\" content=\"Trang tin cập nhật những Meme hài hước, vui nhộn.\" />\n" +
                "<meta name=\"keywords\" content=\"video,sharing,camera,phone,image,post,fun\" />\n" +
                "<meta property=\"fb:app_id\" content=\"624411178792829\" />\n" +
                "<meta property=\"og:url\" content=\"<%= VUE_APP_PROXY %>\">\n" +
                "<meta property=\"og:type\" content=\"website\">\n" +
                "<meta property=\"og:title\" content=\"ChoyDy.Com - Meme hài hước\">\n" +
                "<meta property=\"og:description\" content=\"Trang tin cập nhật những Meme hài hước, vui nhộn.\">\n" +
                "<meta property=\"og:image\" content=\"<%= VUE_APP_PROXY %>/img/logo/full-logo-share.png\">\n" +
                "<meta name=\"twitter:card\" content=\"summary_large_image\">\n" +
                "<meta property=\"twitter:domain\" content=\"choydy.com\">\n" +
                "<meta property=\"twitter:url\" content=\"<%= VUE_APP_PROXY %>\">\n" +
                "<meta name=\"twitter:title\" content=\"ChoyDy.Com - Meme hài hước\">\n" +
                "<meta name=\"twitter:description\" content=\"Trang tin cập nhật những Meme hài hước, vui nhộn.\">\n" +
                "<meta property=\"twitter:image\" content=\"<%= VUE_APP_PROXY %>/img/logo/full-logo-share.png\">";
        String end = text.substring(text.indexOf("<meta E4E8CA427BD17>"));
        try {
            return Response
                    .ok(begin + body + end)
                    .header(HttpHeaders.CACHE_CONTROL, "public,immutable,max-age=1800")
                    .header(HttpHeaders.CONTENT_TYPE, "text/html; charset=utf-8")
                    .build();
        } catch (Exception e) {
            return Response.ok().build();
        }
    }
}
