package org.acme.base;

import io.vertx.core.http.HttpServerRequest;

public class UserAgentInfo {
    public static boolean detectBrowser(HttpServerRequest request) {
        String userAgent = request.getHeader("user-agent");
        if (userAgent == null) {
            return false;
        }
        return userAgent.contains("Mozilla") || userAgent.contains("Opera");
    }
}
