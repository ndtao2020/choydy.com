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
public class LikeType extends BaseId<String> {

    @Transient
    public static final String PATH = "liketype";
    @Transient
    public static final String PATH_ID = "liketype_id";

    @Column(nullable = false)
    private String name;
}
