package org.acme.base;

import org.apache.commons.io.FileUtils;
import org.eclipse.microprofile.config.ConfigProvider;
import org.jboss.logging.Logger;

import javax.enterprise.context.Dependent;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

@Dependent
public class FileStorageService {

    private static final Logger logger = Logger.getLogger(FileStorageService.class);

    private static final String BUCKET_IMAGE = "image";
    private static final String BUCKET_VIDEO = "video";

    private String getDirectory() {
        return ConfigProvider.getConfig().getConfigValue("quarkus.upload.folder").getValue();
    }

    public String uploadImage(String table, String id, String fileName, InputStream file) throws RuntimeException, IOException {
        try {
            String path = "/" + BUCKET_IMAGE + "/" + table + "/" + id + "-" + fileName;
            FileUtils.copyInputStreamToFile(file, new File(getDirectory() + path));
            return path;
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new RuntimeException("Error: ", e);
        }
    }

    public String uploadVideo(String table, String id, String fileName, InputStream file) throws RuntimeException {
        try {
            String path = "/" + BUCKET_VIDEO + "/" + table + "/" + id + "-" + fileName;
            FileUtils.copyInputStreamToFile(file, new File(getDirectory() + path));
            return path;
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new RuntimeException("Error: ", e);
        }
    }
}
