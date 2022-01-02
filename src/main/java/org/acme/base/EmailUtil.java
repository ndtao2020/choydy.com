package org.acme.base;

import io.quarkus.mailer.Mail;
import io.quarkus.mailer.Mailer;

import javax.enterprise.context.Dependent;
import javax.inject.Inject;
import java.io.IOException;

@Dependent
public class EmailUtil {

    @Inject
    Mailer mailer;

    public void sendMailConfirm(String to, String name, String url) throws IOException {
        String builder = "Xin chào " + name + " !\n" +
                "Truy cập liên kết này để xác minh địa chỉ email của bạn.\n" +
                url + "\n" +
                "Nếu bạn không yêu cầu xác minh địa chỉ email này, bạn có thể bỏ qua email này.\n" +
                "Cảm ơn bạn!\n";
        mailer.send(Mail.withText(to, "Xác minh email của bạn", builder));
    }

    public void sendMailResetPassword(String to, String name, String url) throws IOException {
        String builder = "Xin chào " + name + " !\n" +
                "Truy cập liên kết này để đặt lại mật khẩu cho tài khoản " + name + " của bạn.\n" +
                url + "\n" +
                "Nếu bạn không yêu cầu đặt lại mật khẩu, bạn có thể bỏ qua email này.\n" +
                "Cảm ơn bạn!\n";
        mailer.send(Mail.withText(to, "Đặt lại mật khẩu của bạn", builder));
    }
}
