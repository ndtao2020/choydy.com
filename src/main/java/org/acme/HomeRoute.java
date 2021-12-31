package org.acme;

import org.acme.base.FileStorageService;
import org.acme.model.Media;
import org.acme.model.Post;
import org.acme.model.dto.PostDTO;
import org.acme.service.MediaService;
import org.acme.service.PostService;
import org.acme.service.PostTagService;
import org.eclipse.microprofile.config.ConfigProvider;
import org.jboss.resteasy.annotations.jaxrs.PathParam;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.SQLDataException;
import java.util.List;

@Path("/")
public class HomeRoute {

    private static final String S_META = "<meta bf9415284d71d>";
    private static final String E_META = "<meta e4e8ca427bd17>";
    public static final String TEMPLATE_DIR = "/META-INF/resources/index.html";

    @Inject
    PostService postService;
    @Inject
    PostTagService postTagService;
    @Inject
    MediaService mediaService;
    @Inject
    FileStorageService fileStorageService;

    public static Response responseBuilder(Object entity) {
        return Response
                .ok(entity, "text/html;charset=utf-8")
                .header(HttpHeaders.CACHE_CONTROL, "public,immutable,max-age=1800")
                .build();
    }

    @GET
    @Path("/" + Media.PATH + "/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getById(@PathParam String id, @QueryParam("t") String type) throws SQLDataException {
        return Response.ok(fileStorageService.getFile(mediaService.findCacheById(id)), type).build();
    }

    @GET
    @Path("/" + Media.PATH + "/c/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response capture(@PathParam String id, @QueryParam("t") String type) throws IllegalAccessException, SQLDataException, IOException {
        if (!FileStorageService.VIDEO_TYPES.contains(type)) {
            throw new IllegalAccessException("No support for type " + type + " !");
        }
        final String path = fileStorageService.getFullPath(mediaService.findCacheById(id));
        if (path == null) {
            throw new IllegalAccessException("file not found !");
        }
        return Response.ok(new File(fileStorageService.getThumbnail(path)), "image/png").build();
    }

    @GET
    @Path("/" + Post.PATH + "/{id}")
    public Response getOne(@PathParam String id) throws IOException, SQLDataException {
        final InputStream resourceAsStream = HomeRoute.class.getResourceAsStream(TEMPLATE_DIR);
        // fetch data
        PostDTO postDTO = postService.customFindDTOById(id);
        if (postDTO == null) {
            return responseBuilder(resourceAsStream);
        }
        // validate
        String title = postDTO.getTitle();
        String description = postDTO.getContent();
        String url = ConfigProvider.getConfig().getConfigValue("vue.app.proxy").getValue();
        if (title == null || description == null || resourceAsStream == null || url == null) {
            return responseBuilder(resourceAsStream);
        }
        // build
        String text = new String(resourceAsStream.readAllBytes(), StandardCharsets.UTF_8);
        int indexS = text.indexOf(S_META);
        int indexE = text.indexOf(E_META);
        if (indexS == -1 || indexE == -1) {
            return responseBuilder(resourceAsStream);
        }
        title = title.replaceAll("\"", "'");
        if (title.length() <= 80) {
            title += " | " + url.substring(8);
        }
        description = description.replaceAll("\"", "'");
        // substring
        StringBuilder builder = new StringBuilder();
        builder.append(text, 0, indexS);
        // title FB,Twitter
        builder.append("<title>").append(title).append("</title>");
        builder.append("<meta name=\"title\" content=\"").append(title).append("\">");
        builder.append("<meta property=\"og:title\" content=\"").append(title).append("\">");
        builder.append("<meta name=\"twitter:title\" content=\"").append(title).append("\">");
        // description FB,Twitter
        builder.append("<meta name=\"description\" content=\"").append(description).append("\">");
        builder.append("<meta property=\"og:description\" content=\"").append(description).append("\">");
        builder.append("<meta name=\"twitter:description\" content=\"").append(description).append("\">");
        // keywords
        List<?> tags = postTagService.findByPostId(id);
        if (tags != null && !tags.isEmpty()) {
            StringBuilder tagStr = new StringBuilder();
            for (Object obj : tags) {
                tagStr.append(obj.toString()).append(",");
            }
            tagStr.delete(tagStr.length() - 1, tagStr.length());
            // append
            builder.append("<meta name=\"keywords\" content=\"").append(tagStr).append("\">");
        }
        // url
        String fullUrl = url + "/" + Post.PATH + "/" + id;
        builder.append("<link rel=\"canonical\" href=\"").append(fullUrl).append("\">");
        builder.append("<meta property=\"og:url\" content=\"").append(fullUrl).append("\">");
        // link
        List<?> media = mediaService.findByPostId(id);
        if (media != null && !media.isEmpty()) {
            List<?> mediaArr = (List<?>) media.get(0);
            String mediaType = mediaArr.get(1).toString();
            String link = url + "/" + Media.PATH + "/" + mediaArr.get(0) + "?t=" + mediaType;
            // if images
            if (FileStorageService.IMAGE_TYPES.contains(mediaType)) {
                // FB
                builder.append("<meta property=\"og:image\" content=\"").append(link).append("\">");
                builder.append("<meta property=\"og:image:type\" content=\"").append(mediaType).append("\">");
                // twitter
                builder.append("<meta property=\"twitter:card\" content=\"summary_large_image\">");
                builder.append("<meta property=\"twitter:image\" content=\"").append(id).append("\">");
            }
            // if videos
            if (FileStorageService.VIDEO_TYPES.contains(mediaType)) {
                String capture = url + "/" + Media.PATH + "/c/" + mediaArr.get(0) + "?t=" + mediaType;
                // FB
                builder.append("<meta property=\"og:type\" content=\"video.other\">");
                builder.append("<meta property=\"og:video\" content=\"").append(link).append("\">");
                builder.append("<meta property=\"og:video:type\" content=\"").append(mediaType).append("\">");
                builder.append("<meta property=\"og:video:width\" content=\"350\">");
                builder.append("<meta property=\"og:video:height\" content=\"196\">");
                builder.append("<meta property=\"og:image\" content=\"").append(capture).append("\">");
                // twitter
                builder.append("<meta name=\"twitter:card\" content=\"player\">");
                builder.append("<meta name=\"twitter:player\" content=\"").append(link).append("\">");
                builder.append("<meta name=\"twitter:player:width\" content=\"350\">");
                builder.append("<meta name=\"twitter:player:height\" content=\"196\">");
                builder.append("<meta name=\"twitter:image\" content=\"").append(capture).append("\">");
            }
        }
        builder.append(text.substring(indexE));
        // return
        return responseBuilder(builder.toString());
    }
}
