package org.acme.base.jwt;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.Signature;
import java.security.SignatureException;
import java.util.Base64;

public class JwtParser {

    private final ObjectMapper a;
    private final PublicKey p;

    public JwtParser(ObjectMapper mapper, PublicKey publicKey) {
        this.a = mapper;
        this.p = publicKey;
    }

    public JsonNode verify(String t) {
        try {
            String[] r = t.split("\\.");
            byte[] n = r[1].getBytes(StandardCharsets.UTF_8);
            if (!verifySignature(r[0].getBytes(StandardCharsets.UTF_8), n, Base64.getUrlDecoder().decode(r[2]))) {
                throw new SignatureException("Token is invalid !");
            }
            return a.readTree(Base64.getUrlDecoder().decode(n));
        } catch (Exception e) {
            throw new SecurityException(e.getMessage());
        }
    }

    private boolean verifySignature(byte[] headerBytes, byte[] payloadBytes, byte[] signatureBytes) throws SignatureException, NoSuchAlgorithmException, InvalidKeyException {
        Signature s = Signature.getInstance("SHA256withRSA");
        s.initVerify(p);
        s.update(headerBytes);
        s.update((byte) 46);
        s.update(payloadBytes);
        return s.verify(signatureBytes);
    }
}
