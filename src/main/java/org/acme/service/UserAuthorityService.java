package org.acme.service;

import org.acme.base.service.BaseService;
import org.acme.model.UserAuthority;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.Query;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class UserAuthorityService extends BaseService<UserAuthority, UserAuthority, UUID> {

    protected UserAuthorityService() {
        super(UserAuthority.class, UserAuthority.class);
    }

    @Override
    public UserAuthority convertToDTO(UserAuthority data) {
        return data;
    }

    public List<?> findByUserId(UUID id) {
        Query query = getEm().createNativeQuery("select authority_id from user_authority where user_id=?1");
        query.setParameter(1, id);
        return query.getResultList();
    }
}
