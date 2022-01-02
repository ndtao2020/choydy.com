package org.acme.base;

import org.acme.service.Oauth2ClientService;
import org.eclipse.microprofile.config.ConfigProvider;
import org.jboss.logging.Logger;

import javax.enterprise.context.Dependent;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Arrays;
import java.util.Base64;

@Dependent
public class CsrfUtil {

    private static final Logger logger = Logger.getLogger(Oauth2ClientService.class);

    private final String password;

    public CsrfUtil() {
        this.password = ConfigProvider.getConfig().getConfigValue("quarkus.csrf.pass").getValue();
    }

    private String getChain(long time, String ip) {
        return time + ip + this.password;
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
            long random = System.currentTimeMillis() + 604800016;
            byte[] hash = digest(getChain(random, ip));
            return random + "." + Base64.getUrlEncoder().withoutPadding().encodeToString(hash);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public boolean verify(String ip, String encoded) {
        try {
            String[] split = encoded.split("\\.");
            long exp = Long.parseLong(split[0]);
            if (System.currentTimeMillis() >= exp) {
                return false;
            }
            return Arrays.equals(digest(getChain(exp, ip)), Base64.getUrlDecoder().decode(split[1]));
        } catch (Exception e) {
            logger.error(e.getMessage());
            return false;
        }
    }
}
