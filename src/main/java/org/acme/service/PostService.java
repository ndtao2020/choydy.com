package org.acme.service;

import org.acme.base.service.BaseCacheService;
import org.acme.model.Post;
import org.acme.model.dto.PostDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class PostService extends BaseCacheService<Post, PostDTO, UUID> {

    @Inject
    EntityManager em;

    protected PostService() {
        super(Post.class, PostDTO.class, Post.PATH);
    }

    @Override
    public PostDTO convertToDTO(Post data) {
        return new PostDTO(data, data.getUser().getId());
    }

    public List<?> search(int page, int size, String search) {
        String q = "from post ";
        if (search != null) {
            q += "where title like :s or content like :s ";
        }
        Query query = em.createNativeQuery("select CAST (id AS varchar) " + q + "order by created desc");
        if (search != null) {
            query.setParameter("s", "%" + search + "%");
        }
        return query.setFirstResult(page * size).setMaxResults(size).getResultList();
    }
}
