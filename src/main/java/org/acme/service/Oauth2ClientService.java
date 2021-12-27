package org.acme.service;

import io.quarkus.redis.client.RedisClient;
import io.vertx.redis.client.Response;
import org.acme.model.Oauth2Client;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.security.sasl.AuthenticationException;

@ApplicationScoped
public class Oauth2ClientService {

    private static final Logger logger = Logger.getLogger(Oauth2ClientService.class);
    private static final String regex = ",";

    @Inject
    EntityManager em;
    @Inject
    RedisClient redisClient;

    public Object[] loadShortByClientId(String clientId) throws AuthenticationException {
        Object[] data = null;
        try {
            Response r = redisClient.hget("client", clientId);
            if (r != null) {
                data = r.toString().split(regex);
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        if (data == null) {
            Object result = em
                    .createNativeQuery("select secret,access,refresh,domain from " + Oauth2Client.PATH + " where id=?1")
                    .setParameter(1, clientId)
                    .getSingleResult();
            if (result == null) {
                throw new AuthenticationException("Id " + clientId + " is not exist !");
            }
            Object[] out = (Object[]) result;
            try {
                StringBuilder str = new StringBuilder();
                for (Object o : out) {
                    str.append(o).append(regex);
                }
                redisClient.hsetnx("client", clientId, str.substring(0, str.length() - regex.length()));
            } catch (Exception e) {
                logger.error(e.getMessage());
            }
            return out;
        }
        return data;
    }
}
