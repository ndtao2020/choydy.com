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

    public List<?> search(int page, int size) {
        return getEm()
                .createNativeQuery("select CAST (id as varchar),name from " + getTableName(getDomainClass()) + " order by priority desc")
                .setFirstResult(page * size)
                .setMaxResults(size)
                .getResultList();
    }

    public QueryPage search(int page, int size, String search) {
        String q = "from " + getTableName(getDomainClass());
        if (search != null) {
            q += " where name like :s";
        }
        Query query = getEm().createNativeQuery("select CAST (id as varchar),name,priority " + q + " order by priority desc");
        Query cQuery = getEm().createNativeQuery("select count(id) " + q);
        if (search != null) {
            query.setParameter("s", "%" + search + "%");
            cQuery.setParameter("s", "%" + search + "%");
        }
        return new QueryPage(query.setFirstResult(page * size).setMaxResults(size).getResultList(), cQuery.getSingleResult());
    }
}
