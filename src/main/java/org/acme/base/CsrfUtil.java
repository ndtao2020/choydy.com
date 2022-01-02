package org.acme.base;

import net.bytebuddy.utility.RandomString;
import org.eclipse.microprofile.config.ConfigProvider;

import javax.enterprise.context.Dependent;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Arrays;
import java.util.Base64;

@Dependent
public class CsrfUtil {

    private final String password;

    public CsrfUtil() {
        this.password = ConfigProvider.getConfig().getConfigValue("quarkus.csrf.pass").getValue();
    }

    private String getChain(String random, String ip) {
        return random + ip + this.password;
    }

    private byte[] digest(String payload) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            return digest.digest(payload.getBytes(StandardCharsets.UTF_8));
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    // Generating Secret Key using password and salt
    public String compact(String ip) {
        try {
            String random = new RandomString(5).nextString();
            byte[] hash = digest(getChain(random, ip));
            return random + "." + Base64.getUrlEncoder().withoutPadding().encodeToString(hash);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public boolean verify(String ip, String encoded) {
        try {
            String[] r = encoded.split("\\.");
            byte[] hash = digest(getChain(r[0], ip));
            return Arrays.equals(Base64.getUrlDecoder().decode(r[2]), hash);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }
}
