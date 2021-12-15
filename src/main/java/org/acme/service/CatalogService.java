package org.acme.service;

import org.acme.base.service.BaseCacheService;
import org.acme.model.Catalog;
import org.acme.model.dto.CatalogDTO;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class CatalogService extends BaseCacheService<Catalog, CatalogDTO, Long> {

    protected CatalogService() {
        super(Catalog.class, CatalogDTO.class, Catalog.PATH);
    }

    @Override
    public CatalogDTO convertToDTO(Catalog data) {
        return new CatalogDTO(data);
    }
}
