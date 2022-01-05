package org.acme.base.service;

import org.acme.base.BaseId;
import org.acme.base.QueryPage;
import org.jboss.logging.Logger;

import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.Table;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

public abstract class BaseService<T extends BaseId<I>, D extends BaseId<I>, I> {

    private static final Logger logger = Logger.getLogger(BaseService.class);

    private final Class<T> domainClass;
    private final Class<D> dClass;

    @Inject
    EntityManager em;

    protected BaseService(Class<T> domainClass, Class<D> dClass) {
        this.domainClass = domainClass;
        this.dClass = dClass;
    }

    public Logger getLog() {
        return logger;
    }

    public EntityManager getEm() {
        return em;
    }

    public Class<T> getDomainClass() {
        return domainClass;
    }

    public Class<D> getDtoClass() {
        return dClass;
    }

    public <M> String getNameEntity(Class<M> t) {
        return t.getPackageName() + "." + t.getSimpleName();
    }

    public String getTableName(Class<?> tClass) {
        String tableName = tClass.getAnnotation(Table.class).name();
        if (tableName == null || tableName.length() == 0) {
            return toTableName(tClass.getSimpleName());
        }
        return tableName;
    }

    public String toTableName(String name) {
        return name.replace('.', '_').toLowerCase(Locale.ROOT);
    }

    public abstract D convertToDTO(T data);

    public List<D> convertToDTO(List<T> list) {
        List<D> dto = new ArrayList<>();
        for (T pronunciation : list) {
            dto.add(this.convertToDTO(pronunciation));
        }
        return dto;
    }

    public UUID generateId() {
        UUID uuid = UUID.randomUUID();
        List<?> list = getEm()
                .createNativeQuery("select CAST (id AS varchar) from " + getTableName(domainClass) + " where id=?1")
                .setParameter(1, uuid)
                .getResultList();
        if (list != null && !list.isEmpty()) {
            return generateId();
        }
        return uuid;
    }

    public T getById(I id) {
        return em.find(domainClass, id);
    }

    @Transactional
    public <S extends T> S save(S entity) {
        em.persist(entity);
        return entity;
    }

    @Transactional
    public <S extends T> List<S> saveAll(Iterable<S> entities) {
        List<S> result = new ArrayList<S>();
        for (S entity : entities) {
            result.add(save(entity));
        }
        return result;
    }

    @Transactional
    public <S extends T> S update(S entity) {
        return em.merge(entity);
    }

    @Transactional
    public <S extends T> List<S> updateAll(Iterable<S> entities) {
        List<S> result = new ArrayList<S>();
        for (S entity : entities) {
            result.add(update(entity));
        }
        return result;
    }

    @Transactional
    public void delete(T entity) {
        em.remove(em.contains(entity) ? entity : em.merge(entity));
    }

    @Transactional
    public void deleteAll(Iterable<? extends T> entities) {
        for (T entity : entities) {
            delete(entity);
        }
    }

    // ==================================================== [] ====================================================
    private StringBuilder getSearchStr(String search, String... fields) {
        StringBuilder q = new StringBuilder("from " + getTableName(getDomainClass()));
        if (search != null) {
            q.append("where ");
            for (int i = 0; i < fields.length; i++) {
                q.append(fields[i]).append(" like :s ");
                if (i != fields.length - 1) {
                    q.append("or");
                }
            }
        }
        return q;
    }

    private Query getSearchQuery(String search, String order, String... fields) {
        StringBuilder m = new StringBuilder("select CAST (id AS varchar) ");
        m.append(getSearchStr(search, fields));
        if (order != null) {
            m.append(" order by ").append(order).append(" desc");
        }
        Query query = getEm().createNativeQuery(m.toString());
        if (search != null) {
            query.setParameter("s", "%" + search + "%");
        }
        return query;
    }

    protected Query getCountQuery(String search, String... fields) {
        Query query = getEm().createNativeQuery("select count(id) " + getSearchStr(search, fields));
        if (search != null) {
            query.setParameter("s", "%" + search + "%");
        }
        return query;
    }
    // ==================================================== [] ====================================================

    public List<?> search(String search, String order, String... fields) {
        return getSearchQuery(search, order, fields).getResultList();
    }

    public List<?> search(int page, int size, String search, String order, String... fields) {
        return getSearchQuery(search, order, fields)
                .setFirstResult(page * size).setMaxResults(size)
                .getResultList();
    }

    public QueryPage pagination(int page, int size) {
        String query = " from " + getTableName(getDomainClass());
        return new QueryPage(
                getEm()
                        .createNativeQuery("select CAST (id AS varchar)" + query)
                        .setFirstResult(page * size)
                        .setMaxResults(size)
                        .getResultList(),
                getEm()
                        .createNativeQuery("select count(id)" + query)
                        .getSingleResult()
        );
    }

    public QueryPage searchAndPagination(int page, int size, String search, String order, String... fields) {
        return new QueryPage(search(page, size, search, order, fields), getCountQuery(search, fields).getSingleResult());
    }
}
