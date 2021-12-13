package org.acme.service;

import io.minio.BucketExistsArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import io.minio.SetBucketPolicyArgs;
import org.eclipse.microprofile.config.ConfigProvider;

import javax.enterprise.context.ApplicationScoped;
import java.io.InputStream;

@ApplicationScoped
public class MinIOStorageService {

    private final String BUCKET_IMAGE = "image";
    private final String BUCKET_VIDEO = "video";

    private String url;
    private MinioClient minioClient;

    private String getFullUrl(String bucket, String path) {
        return url + "/" + bucket + "/" + path;
    }

    private void initializeMinIOClient() throws RuntimeException {
        try {
            url = ConfigProvider.getConfig().getConfigValue("app.s3.url").getValue();
            // Create instance of minio client with configured service details
            minioClient = MinioClient.builder()
                    .endpoint(url)
                    .credentials(
                            ConfigProvider.getConfig().getConfigValue("app.s3.access-key").getValue(),
                            ConfigProvider.getConfig().getConfigValue("app.s3.secret-key").getValue()
                    )
                    .build();
            // Check and create if bucket is available to store catalogue images
            createBucketIfNotExists(BUCKET_IMAGE);
            createBucketIfNotExists(BUCKET_VIDEO);
        } catch (Exception e) {
            throw new RuntimeException("Error occurred while initializing MinIO Service", e);
        }
    }

    private void createBucketIfNotExists(String bucketName) throws RuntimeException {
        try {
            // Check if the bucket already exists.
            boolean isExist = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build()
            );
            if (!isExist) {
                minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucketName).build());
                minioClient.setBucketPolicy(SetBucketPolicyArgs.builder().bucket(bucketName).config("Public").build());
            }
        } catch (Exception e) {
            throw new RuntimeException("Error occurred while create bucket", e);
        }
    }

    public String uploadImage(String table, String userId, String id, InputStream file) throws RuntimeException {
        try {
            if (minioClient == null) {
                initializeMinIOClient();
            }
            String path = table + "/" + userId + "/" + id;
            // Put the object to bucket
            minioClient.putObject(
                    PutObjectArgs.builder()
                            .object(path)
                            .contentType("image/jpeg")
                            .stream(file, file.available(), -1)
                            .build()
            );
            return getFullUrl(BUCKET_IMAGE, path);
        } catch (Exception e) {
            throw new RuntimeException("Error occurred while uploading catalogue item image for SKU: %s", e);
        }
    }
}
