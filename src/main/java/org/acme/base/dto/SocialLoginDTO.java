package org.acme.base.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.acme.constants.Social;

import javax.validation.constraints.NotNull;

@Data
@EqualsAndHashCode(callSuper = true)
public class SocialLoginDTO extends RegisterDTO {

    @NotNull
    private String id;

    @NotNull
    private String providerId;

    @NotNull
    private Social social;

    private String avatar;
}
