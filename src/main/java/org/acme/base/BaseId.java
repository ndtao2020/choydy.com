package org.acme.base;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Immutable;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

@Getter
@Setter
@Immutable
@MappedSuperclass
@NoArgsConstructor
public abstract class BaseId<I> {

    @Id
    @GeneratedValue
    @Column(updatable = false, nullable = false, unique = true)
    private I id;

    protected BaseId(I id) {
        this.id = id;
    }
}
