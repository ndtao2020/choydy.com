package org.acme.service;

import org.acme.base.dto.RegisterDTO;
import org.acme.base.dto.SocialLoginDTO;
import org.acme.base.service.BaseCacheService;
import org.acme.constants.Role;
import org.acme.model.User;
import org.acme.model.dto.UserDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.transaction.Transactional;
import java.sql.SQLDataException;
import java.sql.SQLException;
import java.util.UUID;

@ApplicationScoped
public class UserService extends BaseCacheService<User, UserDTO, UUID> {

    @Inject
    AuthorityService authorityService;

    @Inject
    SocialNetworkService socialNetworkService;

    protected UserService() {
        super(User.class, UserDTO.class, User.PATH, 2592000L);
    }

    @Override
    public UserDTO convertToDTO(User user) {
        return new UserDTO(user);
    }

    public Object getShortDetail(UUID id) throws SQLDataException {
        String dto = fetchCache(id.toString());
        if (dto == null) {
            Object data = getEm()
                    .createNativeQuery("select name,avatar from " + getTableName(getDomainClass()) + " where id=?1")
                    .setParameter(1, id)
                    .getSingleResult();
            if (data == null) {
                throw new SQLDataException("Data does not exist with id !");
            }
            return this.saveObjectById(id, data, false);
        }
        return dto;
    }

    @Transactional
    public User create(RegisterDTO dto) {
        return this.save(new User(dto, authorityService.getById(Role.USER)));
    }

    @Transactional
    public User create(SocialLoginDTO dto) {
        return this.save(new User(dto, authorityService.getById(Role.USER), socialNetworkService.getByName(dto.getSocial())));
    }

    public User loadUserByUsername(String username) throws SQLException {
        // result
        Object[] data = (Object[]) getEm()
                .createNativeQuery("select CAST (id AS varchar),password,enabled from " + getTableName(getDomainClass()) + " where username=:u or email=:u")
                .setParameter("u", username).getSingleResult();
        if (data == null) {
            throw new SQLException("Username does not exist !");
        }
        User user = new User();
        user.setId(UUID.fromString((String) data[0]));
        user.setPassword((String) data[1]);
        user.setEnabled((Boolean) data[2]);
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
