package org.acme.base.jwt;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.SignatureException;
import java.util.Base64;
import java.util.Map;

public class JwtBuilder {

    private final ObjectMapper a;
    private final String b;
    private final PrivateKey p;

    public JwtBuilder(ObjectMapper mapper, PrivateKey privateKey) {
        try {
            this.a = mapper;
            this.b = encode(toJson(Map.of("alg", "RS256")));
            this.p = privateKey;
        } catch (JsonProcessingException e) {
            throw new IllegalArgumentException(e.getMessage());
        }
    }

    public String compact(Map<String, ?> c) throws JsonProcessingException, SignatureException, NoSuchAlgorithmException, InvalidKeyException {
        String payload = encode(toJson(c));
        return b + "." + payload + "." + sign(b, payload);
    }

    private byte[] toJson(Map<String, ?> data) throws JsonProcessingException {
        return a.writeValueAsBytes(data);
    }

    private String encode(byte[] input) {
        return Base64.getUrlEncoder().withoutPadding().encodeToString(input);
    }

    private String sign(String header, String payload) throws SignatureException, NoSuchAlgorithmException, InvalidKeyException {
        Signature s = Signature.getInstance("SHA256withRSA");
        s.initSign(p);
        s.update(header.getBytes(StandardCharsets.UTF_8));
        s.update((byte) 46);
        s.update(payload.getBytes(StandardCharsets.UTF_8));
        return encode(s.sign());
    }
}
