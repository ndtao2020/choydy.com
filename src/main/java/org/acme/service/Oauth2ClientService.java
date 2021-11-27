package org.acme.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.quarkus.redis.client.RedisClient;
import io.vertx.redis.client.Response;
import org.acme.model.Oauth2Client;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.security.sasl.AuthenticationException;
import java.util.UUID;

@ApplicationScoped
public class Oauth2ClientService {

    @Inject
    Logger log;

    @Inject
    EntityManager em;

    @Inject
    RedisClient redisClient;

    @Inject
    ObjectMapper objectMapper;

    public Oauth2Client loadClientByClientId(UUID clientId) throws AuthenticationException {
        Oauth2Client data;
        try {
            Response response = redisClient.hget("clients", clientId.toString());
            data = objectMapper.readValue(response.toBytes(), Oauth2Client.class);
        } catch (Exception e) {
            data = null;
        }
        if (data == null) {
            Oauth2Client oauth2Client = em.find(Oauth2Client.class, clientId);
            if (oauth2Client == null) {
                throw new AuthenticationException("Id " + clientId + " is not exist !");
            }
            try {
                redisClient.hsetnx("clients", clientId.toString(), objectMapper.writeValueAsString(oauth2Client));
            } catch (Exception e) {
                log.error(e.getMessage());
            }
            return oauth2Client;
        }
        return data;
    }
}
