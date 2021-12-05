package org.acme.service;

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
