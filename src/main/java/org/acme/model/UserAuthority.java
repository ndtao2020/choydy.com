package org.acme.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.acme.base.BaseId;
import org.acme.model.base.AuthorityBase;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;
import java.util.UUID;

@Entity
@Data
@NoArgsConstructor
@Table(uniqueConstraints = @UniqueConstraint(columnNames = {User.PATH_ID, AuthorityBase.PATH_ID}))
@EqualsAndHashCode(callSuper = true)
public class UserAuthority extends BaseId<UUID> {

    @Transient
    public static final String PATH = "userAuthority";

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false)
    private User user;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false)
    private Authority authority;

    public UserAuthority(User user, Authority authority) {
        this.user = user;
        this.authority = authority;
    }
}
