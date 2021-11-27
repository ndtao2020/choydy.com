package org.acme.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.acme.base.dto.RegisterDTO;
import org.acme.model.base.UserDetailBase;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class UserDetail extends UserDetailBase {

    @JsonIgnore
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(nullable = false)
    private User user;

    @JsonProperty
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(nullable = false)
    private Country country;

    public UserDetail(User user, RegisterDTO registerDTO) {
        this.user = user;
        this.country = new Country("VI");
        this.setPhoneNumber(registerDTO.getPhoneNumber());
    }
}
