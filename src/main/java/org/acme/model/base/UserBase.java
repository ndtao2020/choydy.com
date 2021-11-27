package org.acme.model.base;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import java.util.UUID;

@Getter
@Setter
@MappedSuperclass
@NoArgsConstructor
public abstract class UserBase extends BaseEntity<UUID> {

    @NotNull(message = "Name cannot be null")
    @Column(nullable = false)
    private String name;

    @NotNull
    @Email(message = "Email should be valid")
    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private Boolean active;

    @NotNull
    @Column(nullable = false)
    private String timezone;

    private String avatar;

    protected UserBase(UUID id) {
        super(id);
    }

    protected UserBase(UserBase user) {
        super(user.getId());
        this.update(user);
    }

    protected UserBase(String name, String email, Boolean active, String timezone) {
        super(null);
        this.name = name;
        this.email = email;
        this.active = active;
        this.timezone = timezone;
    }

    public void update(UserBase user) {
        this.name = user.getName();
        this.email = user.getEmail();
        this.active = user.getActive();
        this.timezone = user.getTimezone();
        this.avatar = user.getAvatar();
    }
}
