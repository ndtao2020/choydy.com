package org.acme.model.base;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.base.BaseId;
import org.acme.constants.Social;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@MappedSuperclass
@NoArgsConstructor
public abstract class SocialNetworkBase extends BaseId<Integer> {

    @NotNull
    @NotBlank
    @Column(length = 150, nullable = false, unique = true)
    @Enumerated(EnumType.STRING)
    private Social name;

    protected SocialNetworkBase(SocialNetworkBase socialNetworkBase) {
        super(socialNetworkBase.getId());
        this.name = socialNetworkBase.getName();
    }
}
