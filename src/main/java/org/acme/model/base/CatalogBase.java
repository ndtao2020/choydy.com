package org.acme.model.base;

import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public abstract class CatalogBase extends BaseId<Long> {

    @Column(nullable = false)
    private String icon;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private Integer priority;

    @Column(nullable = false)
    private Long created;

    public CatalogBase() {

    }

    public CatalogBase(Long id) {
        super(id);
    }

    public CatalogBase(CatalogBase catalogBase) {
        super(catalogBase.getId());
        this.icon = catalogBase.getIcon();
        this.name = catalogBase.getName();
        this.priority = catalogBase.getPriority();
        this.created = catalogBase.getCreated();
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
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

    public Long getCreated() {
        return created;
    }

    public void setCreated(Long created) {
        this.created = created;
    }
}
