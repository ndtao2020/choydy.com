package org.acme.base;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import java.time.LocalDateTime;

@Getter
@Setter
@MappedSuperclass
@NoArgsConstructor
public abstract class BaseEntity<I> extends BaseId<I> {

    @JsonIgnore
    @Column(name = "created_by")
    private String createdBy;

    @JsonIgnore
    @Column(name = "created_date")
    private LocalDateTime createdDate;

    @JsonIgnore
    @Column(name = "last_modified_by")
    private String lastModifiedBy;

    @JsonIgnore
    @Column(name = "last_modified_date")
    private LocalDateTime lastModifiedDate;

    protected BaseEntity(I id) {
        super(id);
    }
}
