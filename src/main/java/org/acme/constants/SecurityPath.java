package org.acme.constants;

public class SecurityPath {
    private SecurityPath() {
        throw new IllegalStateException("Utility class");
    }

    // Check Token
    public static final String OAUTH_API_URL = "/oauth";
    // Not Check Token
    public static final String PUBLIC_API_URL = "/public";
    // Check Token
    public static final String AUTH_API_URL = "/auth";
    public static final String ADMIN_API_URL = "/admin";
}
