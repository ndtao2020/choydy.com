package org.acme.model.base;

import org.acme.constants.Gender;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.time.LocalDate;

@MappedSuperclass
public abstract class UserDetailBase {

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

    public UserDetailBase() {
    }

    protected UserDetailBase(UserDetailBase userDetailBase) {
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

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public LocalDate getBirthday() {
        return birthday;
    }

    public void setBirthday(LocalDate birthday) {
        this.birthday = birthday;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }
}
