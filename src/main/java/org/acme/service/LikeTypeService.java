package org.acme.service;

import org.acme.base.service.BaseService;
import org.acme.model.LikeType;

import javax.enterprise.context.ApplicationScoped;
import java.util.List;

@ApplicationScoped
public class LikeTypeService extends BaseService<LikeType, LikeType, String> {

    protected LikeTypeService() {
        super(LikeType.class, LikeType.class);
    }

    @Override
    public LikeType convertToDTO(LikeType data) {
        return data;
    }

    public List<?> findAll() {
        return getEm()
                .createNativeQuery("select id,name from " + getTableName(getDomainClass()))
                .getResultList();
    }
}
