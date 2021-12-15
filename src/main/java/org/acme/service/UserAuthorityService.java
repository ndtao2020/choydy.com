package org.acme.service;

import org.acme.base.service.BaseService;
import org.acme.model.Authority;
import org.acme.model.User;
import org.acme.model.UserAuthority;

import javax.enterprise.context.ApplicationScoped;
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
        return getEm()
                .createNativeQuery("select " + Authority.PATH_ID + " from " + getTableName(getDomainClass()) + " where " + User.PATH_ID + "=?1")
                .setParameter(1, id)
                .getResultList();
    }
}
