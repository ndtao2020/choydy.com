package org.acme.base.encoder;

import javax.enterprise.context.Dependent;
import java.nio.charset.StandardCharsets;

@Dependent
public class BCryptPasswordEncoder {

    private final BCrypt bCrypt = new BCrypt();

    public String encode(CharSequence rawPassword) {
        return bCrypt.hashpw(rawPassword.toString().getBytes(StandardCharsets.UTF_8), bCrypt.gensalt("$2a", 10));
    }

    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        return bCrypt.equalsNoEarlyReturn(encodedPassword, bCrypt.hashpw(rawPassword.toString().getBytes(StandardCharsets.UTF_8), encodedPassword));
    }
}
