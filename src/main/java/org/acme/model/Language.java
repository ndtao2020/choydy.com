package org.acme.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Getter
@Setter
@Table
@NoArgsConstructor
public class Language {

    @Transient
    public static final String PATH = "language";

    @Id
    @GeneratedValue
    @Column(nullable = false, length = 2, unique = true)
    private String code;

    @Column(nullable = false, length = 3)
    private String code3;

    @Column(nullable = false)
    private String name;

    @Column
    private String nativeName;
}
