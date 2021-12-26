package org.acme.constants;

public class SecurityPath {
    public static final String PREFIX = "/api";
    // Check Token
    public static final String OAUTH_API_URL = PREFIX + "/o";
    // Not Check Token
    public static final String PUBLIC_API_URL = PREFIX + "/p";
    // Check Token
    public static final String AUTH_API_URL = PREFIX + "/u";
    public static final String ADMIN_API_URL = PREFIX + "/a";
    public static final String EDITOR_API_URL = PREFIX + "/e";

    private SecurityPath() {
        throw new IllegalStateException("Utility class");
    }
}
