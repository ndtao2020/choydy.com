package org.acme.model.base;

import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public abstract class CatalogBase extends BaseId<Long> {

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private Integer priority;

    public CatalogBase() {
    }

    public CatalogBase(Long id) {
        super(id);
    }

    public CatalogBase(CatalogBase catalogBase) {
        super(catalogBase.getId());
        this.name = catalogBase.getName();
        this.priority = catalogBase.getPriority();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }
}
