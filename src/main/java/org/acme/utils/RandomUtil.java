package org.acme.utils;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Random;
import java.util.UUID;

public class RandomUtil {

    static String ALPHA_NUMERIC_STRING = "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ0123456789";

    public static String randomUUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }

    public static String random(int count) throws NoSuchAlgorithmException {
        Random random = SecureRandom.getInstanceStrong();
        int rand = random.nextInt(ALPHA_NUMERIC_STRING.length()); // returns pseudo-random value between 0 and 50
        StringBuilder builder = new StringBuilder();
        while (count-- != 0) {
            builder.append(ALPHA_NUMERIC_STRING.charAt(rand));
        }
        return builder.toString();
    }
}
