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
    private final Long redisTTL;

    @Inject
    ObjectMapper mapper;

    @Inject
    RedisClient redisClient;

    protected BaseCacheService(Class<T> domainClass, Class<D> dClass, String redisKey) {
        this(domainClass, dClass, redisKey, null);
    }

    protected BaseCacheService(Class<T> domainClass, Class<D> dClass, String redisKey, Long ttl) {
        super(domainClass, dClass);
        this.redisKey = redisKey;
        this.redisTTL = ttl;
    }

    protected String getRedisKey() {
        return redisKey;
    }

    protected String getRedisListKey() {
        return redisKey + "-list";
    }

    protected String fetchCache(String key) {
        try {
            return redisClient.hget(getRedisKey(), key).toString();
        } catch (Exception e) {
            return null;
        }
    }

    protected D fetchFromCache(String key) {
        try {
            return mapper.readValue(fetchCache(key), getDtoClass());
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

    public Object findObjectById(I id) {
        Object dto = fetchCache(id.toString());
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
            redisClient.hsetnx(getRedisKey(), id.toString(), mapper.writeValueAsString(data));
            if (redisTTL != null) {
                redisClient.expire(getRedisKey(), redisTTL + "");
            }
        } catch (Exception e) {
            getLog().error(e.getMessage());
        }
        return data;
    }

    public Object saveObjectById(I id, Object data, boolean noParse) {
        try {
            redisClient.hsetnx(getRedisKey(), id.toString(), noParse ? data.toString() : mapper.writeValueAsString(data));
            if (redisTTL != null) {
                redisClient.expire(getRedisKey(), redisTTL + "");
            }
        } catch (Exception e) {
            getLog().error(e.getMessage());
        }
        return data;
    }

    public D updateDTOById(I id, D data) {
        try {
            redisClient.hdel(List.of(getRedisKey(), id.toString()));
            redisClient.hsetnx(getRedisKey(), id.toString(), mapper.writeValueAsString(data));
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
