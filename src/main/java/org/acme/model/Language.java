package org.acme.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table
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

    public Language() {
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCode3() {
        return code3;
    }

    public void setCode3(String code3) {
        this.code3 = code3;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNativeName() {
        return nativeName;
    }

    public void setNativeName(String nativeName) {
        this.nativeName = nativeName;
    }
}
