package org.acme.base;

import org.hibernate.annotations.Immutable;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

@Immutable
@MappedSuperclass
public abstract class BaseId<I> {

    @Id
    @GeneratedValue
    @Column(updatable = false, nullable = false, unique = true)
    private I id;

    public BaseId() {
    }

    protected BaseId(I id) {
        this.id = id;
    }

    public I getId() {
        return id;
    }

    public void setId(I id) {
        this.id = id;
    }
}
