package org.acme.model.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.model.SocialNetwork;
import org.acme.model.base.SocialNetworkBase;

@Getter
@Setter
@NoArgsConstructor
public class SocialNetworkDTO extends SocialNetworkBase {
    public SocialNetworkDTO(SocialNetwork socialNetwork) {
        super(socialNetwork);
    }
}
