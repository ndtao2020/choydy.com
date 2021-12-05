package org.acme.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.base.CatalogBase;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Getter
@Setter
@Table
@NoArgsConstructor
public class Catalog extends CatalogBase {

    @Transient
    public static final String PATH = "catalog";
    @Transient
    public static final String PATH_ID = "catalog_id";

    public Catalog(CatalogBase catalogBase) {
        super(catalogBase);
    }
}
