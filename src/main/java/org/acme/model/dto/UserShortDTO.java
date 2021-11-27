package org.acme.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class UserShortDTO {
    private String name;
    private String avatar;
}
