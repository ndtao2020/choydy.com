package org.acme.base.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotNull;

@Data
@EqualsAndHashCode(callSuper = true)
public class RegisterDTO extends LoginDTO {

    @NotNull
    private String timezone;

    @NotNull
    private String name;

    @NotNull
    private String email;

    private String phoneNumber;
}
