package org.acme.base.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.quarkus.redis.client.RedisClient;
import org.acme.base.BaseId;
import org.acme.base.QueryPage;

import javax.inject.Inject;
import java.util.ArrayList;
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
        try {
            return mapper.readValue(redisClient.hget(getRedisKey(), key).toString(), getDtoClass());
        } catch (Exception e) {
            return null;
        }
    }

    protected <K> K fetchFromCache(String key, Class<K> kClass) {
        try {
            return mapper.readValue(redisClient.hget(getRedisKey(), key).toString(), kClass);
        } catch (Exception e) {
            return null;
        }
    }

    protected List<D> fetchListFromCache(String key) {
        try {
            return mapper.readValue(redisClient.hget(getRedisListKey(), key).toString(), new TypeReference<>() {
            });
        } catch (Exception e) {
            return List.of();
        }
    }

    public D findDTOById(I id) {
        D dto = fetchFromCache(id.toString());
        if (dto == null) {
            T data = super.getById(id);
            return data == null ? null : this.saveDTOById(id, this.convertToDTO(data));
        }
        return dto;
    }

    public D findDTOByObjectId(Object id) {
        D dto = fetchFromCache(id.toString());
        if (dto == null) {
            T data = getEm().find(getDomainClass(), id);
            return data == null ? null : this.saveDTOById(data.getId(), this.convertToDTO(data));
        }
        return dto;
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

    public void deleteDTOById(I id) {
        try {
            redisClient.hdel(List.of(getRedisKey(), id.toString()));
        } catch (Exception e) {
            getLog().error(e.getMessage());
        }
    }

    // ==================================================== [] ====================================================

    public QueryPage searchDTOAndPagination(int page, int size, String search, String order, String... fields) {
        List<D> result = new ArrayList<>();
        for (Object obj : search(page, size, search, order, fields)) {
            result.add(this.findDTOByObjectId(obj));
        }
        return new QueryPage(result, getCountQuery(search, fields).getSingleResult());
    }
}
