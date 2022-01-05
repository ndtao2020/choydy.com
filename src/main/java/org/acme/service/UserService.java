package org.acme.service;

import org.acme.base.dto.RegisterDTO;
import org.acme.base.dto.SocialLoginDTO;
import org.acme.base.service.BaseCacheService;
import org.acme.constants.Role;
import org.acme.constants.Social;
import org.acme.model.Authority;
import org.acme.model.User;
import org.acme.model.UserAuthority;
import org.acme.model.UserDetail;
import org.acme.model.UserSocialNetwork;
import org.acme.model.dto.UserDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.transaction.Transactional;
import java.sql.SQLDataException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class UserService extends BaseCacheService<User, UserDTO, UUID> {

    public static final String TABLE_NAME = "user_sys";

    protected UserService() {
        super(User.class, UserDTO.class, User.PATH, 604800L);
    }

    @Override
    public UserDTO convertToDTO(User user) {
        return new UserDTO(user);
    }

    public Object getShortDetail(String id) throws SQLDataException {
        String dto = fetchCache(id);
        if (dto == null) {
            try {
                UUID uuid = UUID.fromString(id);
                Object data = getEm()
                        .createNativeQuery("select name,avatar from " + TABLE_NAME + " where id=?1")
                        .setParameter(1, uuid)
                        .getSingleResult();
                if (data != null) {
                    return this.saveObjectById(uuid, data, false);
                }
            } catch (Exception e) {
                getLog().error(e.getMessage());
            }
        }
        return dto;
    }

    public User loadUserByUsername(String username) throws SQLException {
        // result
        List<?> resultList = getEm()
                .createNativeQuery("select CAST (id AS varchar),password,enabled from " + TABLE_NAME + " where username=?1 or email=?1")
                .setParameter(1, username)
                .getResultList();
        if (resultList == null || resultList.isEmpty()) {
            return null;
        }
        Object[] objects = (Object[]) resultList.get(0);
        User user = new User();
        user.setId(UUID.fromString((String) objects[0]));
        user.setPassword((String) objects[1]);
        user.setEnabled((Boolean) objects[2]);
        return user;
    }

    public User findByEmail(String email) {
        return getEm()
                .createQuery("from " + TABLE_NAME + " where email=:e", getDomainClass())
                .setParameter("e", email)
                .getSingleResult();
    }

    public User findByUsernameOrEmail(String username, String email) {
        return getEm()
                .createQuery("from " + TABLE_NAME + " where username=:u or email=:e", getDomainClass())
                .setParameter("u", username)
                .setParameter("e", email)
                .getSingleResult();
    }

    public UUID create(RegisterDTO dto, String avatar) {
        // save user
        UUID userId = this.generateId();
        getEm()
                .createNativeQuery(
                        "INSERT INTO " + TABLE_NAME + " (id,avatar,enabled,\"name\",\"password\",username,email,active,timezone)" +
                                " VALUES(:id,:avatar,:enabled,:name,:password,:username,:email,:active,:timezone)"
                )
                .setParameter("id", userId)
                .setParameter("avatar", avatar)
                .setParameter("enabled", avatar != null)
                .setParameter("name", dto.getName())
                .setParameter("password", dto.getPassword())
                .setParameter("username", dto.getUsername())
                .setParameter("email", dto.getEmail())
                .setParameter("active", false)
                .setParameter("timezone", dto.getTimezone())
                .executeUpdate();
        // save Authority
        getEm()
                .createNativeQuery("INSERT INTO " + UserAuthority.PATH + " (" + Authority.PATH_ID + "," + User.PATH_ID + ") VALUES(?1,?2)")
                .setParameter(1, Role.USER.name())
                .setParameter(2, userId)
                .executeUpdate();
        // save detail
        getEm()
                .createNativeQuery("INSERT INTO " + UserDetail.PATH + " (phonenumber,country_iso," + User.PATH_ID + ") VALUES(?1,?2,?3)")
                .setParameter(1, dto.getPhoneNumber())
                .setParameter(2, "VI")
                .setParameter(3, userId)
                .executeUpdate();
        // return
        return userId;
    }

    @Transactional
    public User createWithRegister(RegisterDTO dto) {
        // return
        return new User(this.create(dto, null), true);
    }

    @Transactional
    public User createWithSocial(SocialLoginDTO dto) {
        // save user
        UUID userId = this.create(dto, dto.getAvatar());
        // save SocialNetwork
        getEm()
                .createNativeQuery("INSERT INTO " + UserSocialNetwork.PATH + " (email,phonenumber,uid,social," + User.PATH_ID + ") VALUES(:email,:phonenumber,:uid,:social,:user_id)")
                .setParameter("email", dto.getEmail())
                .setParameter("phonenumber", dto.getPhoneNumber())
                .setParameter("uid", dto.getId())
                .setParameter("social", dto.getSocial().equals(Social.GOOGLE) ? 1 : 2)
                .setParameter("user_id", userId)
                .executeUpdate();
        // return
        return new User(userId, true);
    }
}
