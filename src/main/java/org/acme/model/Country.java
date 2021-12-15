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

    public Country(String iso) {
        this.iso = iso;
    }
}
