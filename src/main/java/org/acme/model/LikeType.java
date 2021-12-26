package org.acme.model;

import org.acme.base.BaseId;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table
public class LikeType extends BaseId<String> {

    @Transient
    public static final String PATH = "liketype";
    @Transient
    public static final String PATH_ID = "liketype_id";

    @Column(nullable = false)
    private String name;

    public LikeType() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
