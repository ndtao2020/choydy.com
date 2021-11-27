package org.acme.model.base;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.acme.base.BaseId;
import org.acme.constants.Gender;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.time.LocalDate;
import java.util.UUID;

@Getter
@Setter
@MappedSuperclass
@NoArgsConstructor
public abstract class UserDetailBase extends BaseId<UUID> {

    @Transient
    public static final String PATH = "userDetail";

    @NotBlank
    @Column(length = 30)
    private String postalCode;

    @Size(min = 5, max = 500, message = "About Me must be between 5 and 500 characters")
    @Column(columnDefinition = "TEXT")
    private String address;

    @NotBlank
    @Column(length = 30)
    private String phoneNumber;

    @Enumerated(EnumType.STRING)
    private Gender gender;

    private LocalDate birthday;

    @Size(min = 20, max = 1000, message = "About Me must be between 20 and 1000 characters")
    @Column(columnDefinition = "TEXT")
    private String about;

    protected UserDetailBase(UserDetailBase userDetailBase) {
        super(userDetailBase.getId());
        this.update(userDetailBase);
    }

    public void update(UserDetailBase userDetail) {
        this.postalCode = userDetail.getPostalCode();
        this.address = userDetail.getAddress();
        this.phoneNumber = userDetail.getPhoneNumber();
        this.gender = userDetail.getGender();
        this.birthday = userDetail.getBirthday();
        this.about = userDetail.getAbout();
    }
}
