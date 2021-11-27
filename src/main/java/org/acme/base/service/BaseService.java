package org.acme.base.service;

import org.acme.base.BaseId;
import org.jboss.logging.Logger;

import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.Table;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public abstract class BaseService<T extends BaseId<I>, D extends BaseId<I>, I> {

    private final Class<T> domainClass;
    private final Class<D> dClass;

    @Inject
    Logger log;

    @Inject
    EntityManager em;

    protected BaseService(Class<T> domainClass, Class<D> dClass) {
        this.domainClass = domainClass;
        this.dClass = dClass;
    }

    public Logger getLog() {
        return log;
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
        if (tableName == null) {
            return toTableName(tClass.getSimpleName());
        }
        return tableName;
    }

    public String toTableName(String name) {
        StringBuilder b = new StringBuilder(name.replace('.', '_'));
        for (int i = 1; i < b.length() - 1; i++) {
            if (Character.isLowerCase(b.charAt(i - 1)) && Character.isUpperCase(b.charAt(i)) && Character.isLowerCase(b.charAt(i + 1))) {
                b.insert(i, '_');
            }
        }
        return b.toString().toLowerCase(Locale.ROOT);
    }

    public abstract D convertToDTO(T data);

    public List<D> convertToDTO(List<T> list) {
        List<D> dto = new ArrayList<>();
        for (T pronunciation : list) {
            dto.add(this.convertToDTO(pronunciation));
        }
        return dto;
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
}
