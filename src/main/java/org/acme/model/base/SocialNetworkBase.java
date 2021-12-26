package org.acme.model.base;

import org.acme.base.BaseId;
import org.acme.constants.Social;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@MappedSuperclass
public abstract class SocialNetworkBase extends BaseId<Integer> {

    @NotNull
    @NotBlank
    @Column(length = 150, nullable = false, unique = true)
    @Enumerated(EnumType.STRING)
    private Social name;

    public SocialNetworkBase() {
    }

    protected SocialNetworkBase(SocialNetworkBase socialNetworkBase) {
        super(socialNetworkBase.getId());
        this.name = socialNetworkBase.getName();
    }

    public Social getName() {
        return name;
    }

    public void setName(Social name) {
        this.name = name;
    }
}
