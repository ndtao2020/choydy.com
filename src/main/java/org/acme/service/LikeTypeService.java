package org.acme.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.quarkus.redis.client.RedisClient;
import io.vertx.redis.client.Response;
import org.acme.model.LikeType;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import java.util.List;

@ApplicationScoped
public class LikeTypeService {

    public static final String KEY = "like_types";

    @Inject
    Logger log;
    @Inject
    EntityManager em;
    @Inject
    RedisClient redisClient;
    @Inject
    ObjectMapper objectMapper;

    public List<?> findAll() {
        List<?> likeTypes;
        try {
            Response response = redisClient.get(KEY);
            likeTypes = objectMapper.readValue(response.toBytes(), List.class);
        } catch (Exception e) {
            likeTypes = null;
        }
        if (likeTypes == null) {
            try {
                List<LikeType> likeTypeList = em.createQuery("from " + LikeType.class.getSimpleName(), LikeType.class).getResultList();
                redisClient.setnx(KEY, objectMapper.writeValueAsString(likeTypeList));
                return likeTypeList;
            } catch (Exception k) {
                log.error(k.getMessage());
            }
        }
        return likeTypes;
    }
}
