package org.acme.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.base.CatalogBase;

@Getter
@Setter
@NoArgsConstructor
public class CatalogDTO extends CatalogBase {
    public CatalogDTO(CatalogBase catalogBase) {
        super(catalogBase);
    }
}
