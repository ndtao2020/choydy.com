package org.acme.base.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.quarkus.redis.client.RedisClient;
import io.vertx.redis.client.Response;
import org.acme.base.BaseId;
import org.acme.base.QueryPage;

import javax.inject.Inject;
import java.util.List;

public abstract class BaseCacheService<T extends BaseId<I>, D extends BaseId<I>, I> extends BaseService<T, D, I> {

    private final String redisKey;

    @Inject
    ObjectMapper mapper;

    @Inject
    RedisClient redisClient;

    protected BaseCacheService(Class<T> domainClass, Class<D> dClass, String redisKey) {
        super(domainClass, dClass);
        this.redisKey = redisKey;
    }

    protected String getRedisKey() {
        return redisKey;
    }

    protected String getRedisListKey() {
        return redisKey + "-list";
    }

    public RedisClient getRedisClient() {
        return redisClient;
    }

    protected D fetchFromCache(String key) {
        D data;
        try {
            Response response = redisClient.hget(getRedisKey(), key);
            data = mapper.readValue(response.toString(), getDtoClass());
        } catch (Exception e) {
            data = null;
        }
        return data;
    }

    protected List<D> fetchListFromCache(String key) {
        try {
            Response response = redisClient.hget(getRedisListKey(), key);
            return mapper.readValue(response.toString(), new TypeReference<>() {
            });
        } catch (Exception e) {
            return List.of();
        }
    }

    public D saveDTOById(I id, D data) {
        try {
            redisClient.hdel(List.of(getRedisKey(), id.toString()));
            redisClient.hsetnx(getRedisKey(), id.toString(), mapper.writeValueAsString(data));
        } catch (Exception e) {
            getLog().error(e.getMessage());
        }
        return data;
    }

    public List<D> saveAllDTOById(I id, List<D> data) {
        try {
            redisClient.hdel(List.of(getRedisListKey(), id.toString()));
            redisClient.hsetnx(getRedisListKey(), id.toString(), mapper.writeValueAsString(data));
        } catch (Exception e) {
            getLog().error(e.getMessage());
        }
        return data;
    }

    public D findDTOById(I id) {
        D dto = fetchFromCache(id.toString());
        if (dto == null) {
            T data = super.getById(id);
            return data == null ? null : this.saveDTOById(id, this.convertToDTO(data));
        }
        return dto;
    }

    public QueryPage pagination(int page, int size) {
        String query = " from " + redisKey;
        return new QueryPage(
                getEm()
                        .createNativeQuery("select *" + query)
                        .setFirstResult(page * size)
                        .setMaxResults(size)
                        .getResultList(),
                getEm()
                        .createNativeQuery("select count(id)" + query)
                        .getSingleResult()
        );
    }
}
