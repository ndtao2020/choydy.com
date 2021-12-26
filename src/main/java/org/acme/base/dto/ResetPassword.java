package org.acme.base.dto;

public class ResetPassword {
    private String newPassword;
    private String reNewPassword;

    public ResetPassword() {
    }

    public ResetPassword(String newPassword, String reNewPassword) {
        this.newPassword = newPassword;
        this.reNewPassword = reNewPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getReNewPassword() {
        return reNewPassword;
    }

    public void setReNewPassword(String reNewPassword) {
        this.reNewPassword = reNewPassword;
    }
}
