package org.acme.model;

import org.acme.model.base.CatalogBase;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table
public class Catalog extends CatalogBase {

    @Transient
    public static final String PATH = "catalog";
    @Transient
    public static final String PATH_ID = "catalog_id";

    public Catalog() {
    }

    public Catalog(Long id) {
        super(id);
    }

    public Catalog(CatalogBase catalogBase) {
        super(catalogBase);
    }
}
