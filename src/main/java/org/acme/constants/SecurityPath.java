package org.acme.constants;

public class SecurityPath {
    public static final String PREFIX = "/api";
    // Check Token
    public static final String OAUTH_API_URL = PREFIX + "/oauth";
    // Not Check Token
    public static final String PUBLIC_API_URL = PREFIX + "/public";
    // Check Token
    public static final String AUTH_API_URL = PREFIX + "/auth";
    public static final String ADMIN_API_URL = PREFIX + "/admin";
    public static final String EDITOR_API_URL = PREFIX + "/editor";

    private SecurityPath() {
        throw new IllegalStateException("Utility class");
    }
}
