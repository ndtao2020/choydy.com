package org.acme.service;

import org.acme.base.dto.RegisterDTO;
import org.acme.base.dto.SocialLoginDTO;
import org.acme.base.service.BaseCacheService;
import org.acme.constants.Role;
import org.acme.model.Authority;
import org.acme.model.User;
import org.acme.model.UserAuthority;
import org.acme.model.dto.UserDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.transaction.Transactional;
import java.sql.SQLDataException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class UserService extends BaseCacheService<User, UserDTO, UUID> {

    @Inject
    AuthorityService authorityService;
    @Inject
    UserSocialNetworkService userSocialNetworkService;

    protected UserService() {
        super(User.class, UserDTO.class, User.PATH, 2592000L);
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
                        .createNativeQuery("select name,avatar from " + getTableName(getDomainClass()) + " where id=?1")
                        .setParameter(1, uuid)
                        .getSingleResult();
                if (data == null) {
                    throw new SQLDataException("Data does not exist with id !");
                }
                return this.saveObjectById(uuid, data, false);
            } catch (Exception e) {
                getLog().error(e.getMessage());
            }
        }
        return dto;
    }

    @Transactional
    public User create(RegisterDTO dto) {
        return this.save(new User(dto, authorityService.getById(Role.USER)));
    }

    @Transactional
    public User create(SocialLoginDTO dto) {
        Authority authority = authorityService.getById(Role.USER);
        // save user
        User user = this.save(new User(dto, authority));
        // save Authority
        authorityService.save(new UserAuthority(user, authority));
        // save SocialNetwork
        userSocialNetworkService.create(dto, user);
        // return
        return user;
    }

    public User loadUserByUsername(String username) throws SQLException {
        // result
        List<?> resultList = getEm()
                .createNativeQuery("select CAST (id AS varchar),password,enabled from user_sys where username=?1 or email=?1")
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
                .createQuery("from " + getNameEntity(getDomainClass()) + " where email=:e", getDomainClass())
                .setParameter("e", email)
                .getSingleResult();
    }

    public User findByUsernameOrEmail(String username, String email) {
        return getEm()
                .createQuery("from " + getNameEntity(getDomainClass()) + " where username=:u or email=:e", getDomainClass())
                .setParameter("u", username)
                .setParameter("e", email)
                .getSingleResult();
    }
}
