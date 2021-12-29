package org.acme.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.acme.model.base.CatalogBase;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table
public class Catalog extends CatalogBase {

    @JoinColumn
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    private Catalog parent;

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

    public Catalog getParent() {
        return parent;
    }

    public void setParent(Catalog parent) {
        this.parent = parent;
    }
}
