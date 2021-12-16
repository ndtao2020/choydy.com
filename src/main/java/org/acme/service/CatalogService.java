package org.acme.service;

import org.acme.base.QueryPage;
import org.acme.base.service.BaseCacheService;
import org.acme.model.Catalog;
import org.acme.model.dto.CatalogDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.Query;

@ApplicationScoped
public class CatalogService extends BaseCacheService<Catalog, CatalogDTO, Long> {

    protected CatalogService() {
        super(Catalog.class, CatalogDTO.class, Catalog.PATH);
    }

    @Override
    public CatalogDTO convertToDTO(Catalog data) {
        return new CatalogDTO(data);
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
