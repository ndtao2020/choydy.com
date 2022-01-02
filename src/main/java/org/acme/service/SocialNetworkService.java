package org.acme.service;

import org.acme.base.service.BaseService;
import org.acme.constants.Social;
import org.acme.model.SocialNetwork;
import org.acme.model.dto.SocialNetworkDTO;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class SocialNetworkService extends BaseService<SocialNetwork, SocialNetworkDTO, Integer> {

    protected SocialNetworkService() {
        super(SocialNetwork.class, SocialNetworkDTO.class);
    }

    @Override
    public SocialNetworkDTO convertToDTO(SocialNetwork data) {
        return new SocialNetworkDTO(data);
    }

    public SocialNetwork getByName(Social social) {
        return getEm()
                .createQuery("from " + getNameEntity(getDomainClass()) + " where name=?1", getDomainClass())
                .setParameter(1, social)
                .getSingleResult();
    }
}
