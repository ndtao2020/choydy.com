package org.acme.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.base.AuthorityBase;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

@Getter
@Setter
@Entity
@Table
@NoArgsConstructor
public class Authority extends AuthorityBase {

    @Transient
    public static final String PATH = "authority";
    @Transient
    public static final String PATH_ID = "authority_id";

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = Authority.PATH)
    private transient List<UserAuthority> accountAuthorities;
}
