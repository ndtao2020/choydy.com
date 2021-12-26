package org.acme.model.dto;

import org.acme.model.SocialNetwork;
import org.acme.model.base.SocialNetworkBase;

public class SocialNetworkDTO extends SocialNetworkBase {
    public SocialNetworkDTO() {
    }

    public SocialNetworkDTO(SocialNetwork socialNetwork) {
        super(socialNetwork);
    }
}
