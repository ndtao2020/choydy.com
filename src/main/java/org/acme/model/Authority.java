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
import java.util.List;

@Getter
@Setter
@Entity
@Table
@NoArgsConstructor
public class Authority extends AuthorityBase {

    @JsonIgnore
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "authority")
    private transient List<UserAuthority> accountAuthorities;
}
