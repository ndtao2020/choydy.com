package org.acme.base;

import org.apache.commons.io.FileUtils;
import org.eclipse.microprofile.config.ConfigProvider;
import org.jboss.logging.Logger;

import javax.enterprise.context.Dependent;
import java.io.File;
import java.io.InputStream;
import java.util.Calendar;
import java.util.List;

@Dependent
public class FileStorageService {

    public static final List<String> IMAGE_TYPES = List.of("image/jpeg", "image/png", "image/gif");
    public static final List<String> VIDEO_TYPES = List.of("video/mp4", "video/webm");
    private static final Logger logger = Logger.getLogger(FileStorageService.class);
    private static final String BUCKET_IMAGE = "img";
    private static final String BUCKET_VIDEO = "vid";
    private final String url = ConfigProvider.getConfig().getConfigValue("quarkus.upload.folder").getValue();

    private String generatePathFile(String bucket, String table, String id, String fileName) {
        Calendar c = Calendar.getInstance();
        String year = c.get(Calendar.YEAR) + "";
        return "/" + bucket + "/" + year.substring(2) + "/" + (c.get(Calendar.MONTH) + 1) + "/" + table + id + fileName;
    }

    public File getFile(String path) {
        return new File(url + path);
    }

    public void deleteFile(String path) {
        try {
            FileUtils.delete(getFile(path));
        } catch (Exception e) {
            logger.error("deleteFile: " + e.getMessage());
            throw new RuntimeException("Error: ", e);
        }
    }

    public String uploadImage(String table, String id, String fileName, InputStream inputStream) {
        try {
            String path = generatePathFile(BUCKET_IMAGE, table, id, fileName);
            FileUtils.copyInputStreamToFile(inputStream, getFile(path));
            return path;
        } catch (Exception e) {
            logger.error("uploadImage: " + e.getMessage());
            throw new RuntimeException("Error: ", e);
        }
    }

    public String uploadVideo(String table, String id, String fileName, InputStream inputStream) {
        try {
            String path = generatePathFile(BUCKET_VIDEO, table, id, fileName);
            FileUtils.copyInputStreamToFile(inputStream, getFile(path));
            return path;
        } catch (Exception e) {
            logger.error("uploadVideo: " + e.getMessage());
            throw new RuntimeException("Error: ", e);
        }
    }
}
