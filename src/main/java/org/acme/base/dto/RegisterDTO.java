package org.acme.base.dto;

import javax.validation.constraints.NotNull;

public class RegisterDTO extends LoginDTO {

    @NotNull
    private String timezone;

    @NotNull
    private String name;

    @NotNull
    private String email;

    private String phoneNumber;

    public RegisterDTO() {
    }

    public String getTimezone() {
        return timezone;
    }

    public void setTimezone(String timezone) {
        this.timezone = timezone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}
