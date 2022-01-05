package org.acme.service;

import org.acme.model.UserDetail;
import org.acme.model.dto.UserDTO;
import org.acme.model.dto.UserDetailDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.UUID;

@ApplicationScoped
public class UserDetailService {

    @Inject
    EntityManager em;
    @Inject
    UserService userService;

    public UserDetailDTO convertToDTO(UserDetail data) {
        UserDetailDTO userDetailDTO = new UserDetailDTO(data);
        userDetailDTO.setUserId(data.getUser().getId());
        userDetailDTO.setCountryIso(data.getCountry().getIso());
        return userDetailDTO;
    }

    public UserDetail getByUserId(UUID userId) {
        return em
                .createQuery("from UserDetail where user.id=:i", UserDetail.class)
                .setParameter("i", userId)
                .getSingleResult();
    }

    public UserDetailDTO findByUserId(UUID userId) {
        UserDTO userDTO = userService.findDTOById(userId);
        if (userDTO == null) {
            return null;
        }
        UserDetailDTO dto = userDTO.getDetail();
        if (dto == null) {
            UserDetail userDetail = this.getByUserId(userId);
            if (userDetail == null) {
                return null;
            }
            UserDetailDTO userDetailDTO = this.convertToDTO(userDetail);
            // set new cache
            userDTO.setDetail(userDetailDTO);
            userService.updateDTOById(userId, userDTO);
            // return
            return userDetailDTO;
        }
        return dto;
    }

    public void updateCache(UUID userId, UserDetail userDetail) throws NullPointerException {
        UserDTO userDTO = userService.findDTOById(userId);
        if (userDTO == null) {
            throw new NullPointerException("User id does not exist to update cache !");
        }
        // set new cache
        userDTO.setDetail(this.convertToDTO(userDetail));
        userService.updateDTOById(userId, userDTO);
    }

    @Transactional
    public UserDetail update(UserDetail userDetail) {
        return em.merge(userDetail);
    }
}
