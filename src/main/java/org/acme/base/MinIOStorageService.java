package org.acme.base;

import io.minio.BucketExistsArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import org.apache.commons.io.IOUtils;
import org.eclipse.microprofile.config.ConfigProvider;
import org.jboss.logging.Logger;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

public class MinIOStorageService {

    private static final Logger logger = Logger.getLogger(MinIOStorageService.class);

    private final String BUCKET_IMAGE = "image";
    private final String BUCKET_VIDEO = "video";

    private final MinioClient minioClient;

    public MinIOStorageService() {
        try {
            // Create instance of minio client with configured service details
            minioClient = MinioClient.builder()
                    .endpoint(ConfigProvider.getConfig().getConfigValue("app.s3.url").getValue())
                    .credentials(
                            ConfigProvider.getConfig().getConfigValue("app.s3.access").getValue(),
                            ConfigProvider.getConfig().getConfigValue("app.s3.secret").getValue()
                    )
                    .build();
            // Check and create if bucket is available to store catalogue images
            createBucketIfNotExists(BUCKET_IMAGE);
            createBucketIfNotExists(BUCKET_VIDEO);
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new RuntimeException("Error occurred while initializing MinIO Service", e);
        }
    }

    private String getFullUrl(String bucket, String path) {
        return "/" + bucket + "/" + path;
    }

    private void createBucketIfNotExists(String bucketName) throws RuntimeException {
        try {
            // Check if the bucket already exists.
            boolean isExist = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build());
            if (!isExist) {
                minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucketName).build());
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new RuntimeException("Error occurred while create bucket", e);
        }
    }

    public String uploadImage(String table, String id, String fileType, String fileName, InputStream file) throws RuntimeException, IOException {
        try {
            byte[] targetArray = IOUtils.toByteArray(file);
            String path = table + "/" + id + "-" + fileName;
            // Put the object to bucket
            minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(BUCKET_IMAGE)
                            .object(path)
                            .contentType(fileType)
                            .stream(new ByteArrayInputStream(targetArray), targetArray.length, -1)
                            .build()
            );
            return getFullUrl(BUCKET_IMAGE, path);
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new RuntimeException("Error: ", e);
        }
    }

    public String uploadVideo(String table, String id, String fileType, String fileName, InputStream file) throws RuntimeException {
        try {
            byte[] targetArray = IOUtils.toByteArray(file);
            String path = table + "/" + id + "-" + fileName;
            // Put the object to bucket
            minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(BUCKET_VIDEO)
                            .object(path)
                            .contentType(fileType)
                            .stream(new ByteArrayInputStream(targetArray), targetArray.length, -1)
                            .build()
            );
            return getFullUrl(BUCKET_VIDEO, path);
        } catch (Exception e) {
            logger.error(e.getMessage());
            throw new RuntimeException("Error: ", e);
        }
    }
}
