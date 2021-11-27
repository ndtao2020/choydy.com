package org.acme.service;

import org.acme.base.service.BaseService;
import org.acme.model.UserDetail;
import org.acme.model.dto.UserDTO;
import org.acme.model.dto.UserDetailDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.UUID;

@ApplicationScoped
public class UserDetailService extends BaseService<UserDetail, UserDetailDTO, UUID> {

    @Inject
    UserService userService;

    protected UserDetailService() {
        super(UserDetail.class, UserDetailDTO.class);
    }

    @Override
    public UserDetailDTO convertToDTO(UserDetail data) {
        UserDetailDTO userDetailDTO = new UserDetailDTO(data);
        userDetailDTO.setUserId(data.getUser().getId());
        userDetailDTO.setCountryIso(data.getCountry().getIso());
        return userDetailDTO;
    }

    public UserDetail getByUserId(UUID userId) {
        return getEm()
                .createQuery("from " + getTableName(getDomainClass()) + " where user.id=:i", UserDetail.class)
                .setParameter("i", userId)
                .getSingleResult();
    }

    public UserDetailDTO findByUserId(UUID userId) {
        UserDTO userDTO = userService.findDTOById(userId);
        if (userDTO == null) {
            return null;
        }
        UserDetailDTO userDetailDTO = userDTO.getDetail();
        if (userDetailDTO == null) {
            UserDetail userDetail = this.getByUserId(userId);
            if (userDetail == null) {
                return null;
            }
            UserDetailDTO userDetailDTO1 = this.convertToDTO(userDetail);
            // set new cache
            userDTO.setDetail(userDetailDTO1);
            userService.saveDTOById(userId, userDTO);
            // return
            return userDetailDTO1;
        }
        return userDetailDTO;
    }

    public void updateCache(UUID userId, UserDetail userDetail) throws NullPointerException {
        UserDTO userDTO = userService.findDTOById(userId);
        if (userDTO == null) {
            throw new NullPointerException("User id does not exist to update cache !");
        }
        // set new cache
        userDTO.setDetail(this.convertToDTO(userDetail));
        userService.saveDTOById(userId, userDTO);
    }
}
