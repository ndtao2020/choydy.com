package org.acme.service;

import org.acme.base.QueryPage;
import org.acme.base.service.BaseCacheService;
import org.acme.model.Catalog;
import org.acme.model.dto.CatalogDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.Query;
import java.util.List;

@ApplicationScoped
public class CatalogService extends BaseCacheService<Catalog, CatalogDTO, Long> {

    protected CatalogService() {
        super(Catalog.class, CatalogDTO.class, Catalog.PATH);
    }

    @Override
    public CatalogDTO convertToDTO(Catalog data) {
        return new CatalogDTO(data);
    }

    public Object findById(Long id) {
        return getEm()
                .createNativeQuery("select name from " + getTableName(getDomainClass()) + " where id=?1")
                .setParameter(1, id)
                .getResultList();
    }

    public List<?> search(Integer page, Integer size) {
        Query query = getEm().createNativeQuery("select id,name,priority,parent_id from " + getTableName(getDomainClass()));
        if (page != null && size != null) {
            query.setFirstResult(page * size);
            query.setMaxResults(size);
        }
        return query.getResultList();
    }

    public QueryPage search(int page, int size, String search) {
        String q = "from " + getTableName(getDomainClass());
        if (search != null) {
            q += " where name like :s";
        }
        Query query = getEm().createNativeQuery("select id,name,priority " + q);
        Query cQuery = getEm().createNativeQuery("select count(id) " + q);
        if (search != null) {
            query.setParameter("s", "%" + search + "%");
            cQuery.setParameter("s", "%" + search + "%");
        }
        return new QueryPage(query.setFirstResult(page * size).setMaxResults(size).getResultList(), cQuery.getSingleResult());
    }
}
