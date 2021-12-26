package org.acme.base.dto;

public class CheckDTO {
    private Boolean check;

    public CheckDTO() {
    }

    public CheckDTO(Boolean check) {
        this.check = check;
    }

    public Boolean getCheck() {
        return check;
    }

    public void setCheck(Boolean check) {
        this.check = check;
    }
}
