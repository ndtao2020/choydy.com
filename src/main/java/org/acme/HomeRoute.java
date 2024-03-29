package org.acme;

import org.acme.base.FileStorageService;
import org.acme.base.jwt.JwtUtil;
import org.acme.model.Media;
import org.acme.model.Post;
import org.acme.model.User;
import org.acme.model.dto.PostDTO;
import org.acme.service.MediaService;
import org.acme.service.PostService;
import org.acme.service.PostTagService;
import org.acme.service.UserService;
import org.eclipse.microprofile.config.ConfigProvider;
import org.jboss.logging.Logger;
import org.jboss.resteasy.annotations.jaxrs.PathParam;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Response;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.SQLDataException;
import java.util.List;
import java.util.UUID;

@Path("/")
public class HomeRoute {

    public static final String TEMPLATE_DIR = "/META-INF/resources/index.html";
    public static final String PATH_VERIFY_EMAIL = "/verify/email";

    private static final Logger logger = Logger.getLogger(HomeRoute.class);
    private static final String S_META = "<meta bf9415284d71d>";
    private static final String E_META = "<meta e4e8ca427bd17>";
    private static final String PATH_POST = "/" + Post.PATH;
    private static final String PATH_MEDIA = "/" + Media.PATH;
    private static final String PATH_MEDIA_CAPTURE = PATH_MEDIA + "/c";

    @Inject
    JwtUtil jwtUtil;
    @Inject
    UserService userService;
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
                .header(HttpHeaders.CACHE_CONTROL, "public,immutable,max-age=18000")
                .build();
    }

    @GET
    public Response home() throws SQLDataException {
        return responseBuilder(HomeRoute.class.getResourceAsStream(HomeRoute.TEMPLATE_DIR));
    }

    @GET
    @Path(PATH_VERIFY_EMAIL)
    public Response verifyEmail(@QueryParam("t") String token) throws SQLDataException {
        if (token == null) {
            return Response.ok().status(Response.Status.MOVED_PERMANENTLY).header(HttpHeaders.LOCATION, "/verify/failed").build();
        }
        UUID id;
        try {
            id = jwtUtil.getId(jwtUtil.validate(token));
        } catch (Exception e) {
            logger.error(e.getMessage());
            return Response.ok().status(Response.Status.MOVED_PERMANENTLY).header(HttpHeaders.LOCATION, "/verify/failed").build();
        }
        if (id == null) {
            logger.error("id == null");
            return Response.ok().status(Response.Status.MOVED_PERMANENTLY).header(HttpHeaders.LOCATION, "/verify/failed").build();
        }
        User user = userService.getById(id);
        if (Boolean.TRUE.equals(user.getActive())) {
            return Response.ok().status(Response.Status.MOVED_PERMANENTLY).header(HttpHeaders.LOCATION, "/").build();
        }
        try {
            user.setActive(true);
            userService.update(user);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return Response.ok()
                .status(Response.Status.MOVED_PERMANENTLY)
                .header(HttpHeaders.LOCATION, "/verify/success")
                .build();
    }

    @GET
    @Path(PATH_MEDIA + "/{id}")
    public Response getById(@PathParam String id, @QueryParam("t") String type) throws SQLDataException {
        return Response.ok(fileStorageService.getFile(mediaService.findCacheById(id)), type).build();
    }

    @GET
    @Path(PATH_MEDIA_CAPTURE + "/{id}")
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
    @Path(PATH_POST + "/{id}")
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
        String fullUrl = url + PATH_POST + "/" + id;
        builder.append("<link rel=\"canonical\" href=\"").append(fullUrl).append("\">");
        builder.append("<meta property=\"og:url\" content=\"").append(fullUrl).append("\">");
        // link
        List<?> media = mediaService.findByPostId(id);
        if (media != null && !media.isEmpty()) {
            List<?> mediaArr = (List<?>) media.get(0);
            String mediaType = mediaArr.get(1).toString();
            String link = url + PATH_MEDIA + "/" + mediaArr.get(0) + "?t=" + mediaType;
            // if images
            if (FileStorageService.IMAGE_TYPES.contains(mediaType)) {
                // FB
                builder.append("<meta property=\"og:image\" content=\"").append(link).append("\">");
                builder.append("<meta property=\"og:image:type\" content=\"").append(mediaType).append("\">");
                // twitter
                builder.append("<meta name=\"twitter:card\" content=\"summary_large_image\">");
                builder.append("<meta name=\"twitter:image\" content=\"").append(link).append("\">");
            }
            // if videos
            if (FileStorageService.VIDEO_TYPES.contains(mediaType)) {
                String capture = url + PATH_MEDIA_CAPTURE + "/" + mediaArr.get(0) + "?t=" + mediaType;
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
