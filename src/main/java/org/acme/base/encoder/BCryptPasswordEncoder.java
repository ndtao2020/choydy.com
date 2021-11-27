package org.acme.base.encoder;

import javax.enterprise.context.Dependent;
import java.util.regex.Pattern;

@Dependent
public class BCryptPasswordEncoder {

    private final Pattern BCRYPT_PATTERN = Pattern.compile("\\A\\$2(a|y|b)?\\$(\\d\\d)\\$[./0-9A-Za-z]{53}");
    private final String salt = BCrypt.gensalt("$2a", 10);

    public String encode(CharSequence rawPassword) {
        if (rawPassword == null) {
            throw new IllegalArgumentException("rawPassword cannot be null");
        }
        return BCrypt.hashpw(rawPassword.toString(), salt);
    }

    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        if (!BCRYPT_PATTERN.matcher(encodedPassword).matches()) {
            return false;
        }
        return BCrypt.checkpw(rawPassword.toString(), encodedPassword);
    }
}
