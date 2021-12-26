package org.acme.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table
public class Country {

    @Transient
    public static final String PATH = "country";
    @Id
    @GeneratedValue
    @Column(nullable = false, length = 2, unique = true)
    private String iso;
    @Column(nullable = false, length = 3)
    private String iso3;
    @Column(nullable = false)
    private String name;
    @Column(name = "display_name", nullable = false)
    private String displayName;
    @Column(name = "num_code", nullable = false)
    private Integer numCode;
    @Column(name = "phone_code", nullable = false)
    private Integer phoneCode;

    public Country() {
    }

    public Country(String iso) {
        this.iso = iso;
    }

    public String getIso() {
        return iso;
    }

    public void setIso(String iso) {
        this.iso = iso;
    }

    public String getIso3() {
        return iso3;
    }

    public void setIso3(String iso3) {
        this.iso3 = iso3;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public Integer getNumCode() {
        return numCode;
    }

    public void setNumCode(Integer numCode) {
        this.numCode = numCode;
    }

    public Integer getPhoneCode() {
        return phoneCode;
    }

    public void setPhoneCode(Integer phoneCode) {
        this.phoneCode = phoneCode;
    }
}
