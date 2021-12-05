package org.acme.model.base;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import java.sql.Timestamp;

@Getter
@Setter
@MappedSuperclass
@NoArgsConstructor
public abstract class CatalogBase extends BaseId<Long> {

    @Column(nullable = false)
    private String icon;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private Integer priority;

    @Column(nullable = false)
    private Timestamp created;

    public CatalogBase(CatalogBase catalogBase) {
        super(catalogBase.getId());
        this.icon = catalogBase.getIcon();
        this.name = catalogBase.getName();
        this.priority = catalogBase.getPriority();
        this.created = catalogBase.getCreated();
    }
}
