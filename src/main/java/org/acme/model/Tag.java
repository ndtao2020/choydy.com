package org.acme.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Getter
@Setter
@Table
@NoArgsConstructor
public class Tag extends BaseId<String> {

    @Transient
    public static final String PATH = "tag";
    @Transient
    public static final String PATH_ID = "tag_id";

    @Column(columnDefinition = "TEXT")
    private String description;

    public Tag(String id) {
        super(id);
    }
}
