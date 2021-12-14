package org.acme.service;

import org.acme.base.service.BaseCacheService;
import org.acme.model.Tag;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.Query;
import java.util.List;

@ApplicationScoped
public class TagService extends BaseCacheService<Tag, Tag, String> {

    protected TagService() {
        super(Tag.class, Tag.class, Tag.PATH);
    }

    @Override
    public Tag convertToDTO(Tag data) {
        return data;
    }

    public List<?> search(int page, int size, String search) {
        String q = "from catalog ";
        if (search != null) {
            q += "where name like :s ";
        }
        Query query = getEm().createNativeQuery("select CAST (id AS varchar) " + q + "order by created desc");
        if (search != null) {
            query.setParameter("s", "%" + search + "%");
        }
        return query.setFirstResult(page * size).setMaxResults(size).getResultList();
    }
}
