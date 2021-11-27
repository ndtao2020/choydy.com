package org.acme.base.jwt;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.acme.base.auth.ClientPrincipal;
import org.acme.base.auth.JwtAuthentication;
import org.acme.base.dto.JwtToken;
import org.eclipse.microprofile.config.ConfigProvider;

import javax.enterprise.context.Dependent;
import java.security.InvalidKeyException;
import java.security.KeyPair;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Dependent
public class JwtUtil {

    private static final String KEY_ID = "a";
    private static final String KEY_ROLE = "b";
    private static final String KEY_EXP = "exp";

    private final JwtBuilder b;
    private final JwtParser p;

    public JwtUtil(ObjectMapper mapper) {
        KeyPair keyPair = new RSAUtil().getKeyPair(
                ConfigProvider.getConfig().getConfigValue("quarkus.keystore.path").getValue(),
                ConfigProvider.getConfig().getConfigValue("quarkus.keystore.pass").getValue(),
                ConfigProvider.getConfig().getConfigValue("quarkus.keystore.alias").getValue()
        );
        this.b = new JwtBuilder(mapper, keyPair.getPrivate());
        this.p = new JwtParser(mapper, keyPair.getPublic());
    }

    private String build(Map<String, ?> claims) {
        try {
            return b.compact(claims);
        } catch (JsonProcessingException | SignatureException | NoSuchAlgorithmException | InvalidKeyException e) {
            throw new IllegalArgumentException(e.getMessage());
        }
    }

    private Long millisToDate(long timeStamp) {
        return System.currentTimeMillis() / 1000 + timeStamp;
    }

    public String builderTokenToVerify(UUID id) {
        return build(Map.of(KEY_ID, id, KEY_EXP, millisToDate(1800)));
    }

    public JwtToken builder(UUID id, List<?> authorities, ClientPrincipal clientPrincipal) {
        return new JwtToken(
                build(Map.of(
                        KEY_ID, id,
                        KEY_ROLE, authorities,
                        KEY_EXP, millisToDate(clientPrincipal.getAccessTokenValidity())
                )),
                build(Map.of(
                        KEY_ID, id,
                        KEY_EXP, millisToDate(clientPrincipal.getRefreshTokenValidity())
                )),
                clientPrincipal.getAccessTokenValidity()
        );
    }

    public JsonNode validate(String t) {
        JsonNode j = p.verify(t);
        if (System.currentTimeMillis() / 1000 > j.get(KEY_EXP).longValue()) {
            throw new IllegalArgumentException("Token has expired !");
        }
        return j;
    }

    public UUID getId(JsonNode c) {
        return UUID.fromString(c.get(KEY_ID).textValue());
    }

    public Iterator<JsonNode> getRoles(JsonNode c) {
        return c.get(KEY_ROLE).elements();
    }

    public JwtAuthentication parse(JsonNode c) {
        return new JwtAuthentication(this.getId(c));
    }
}
