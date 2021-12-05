package org.acme.service;

import org.acme.base.service.BaseCacheService;
import org.acme.model.Post;
import org.acme.model.dto.PostDTO;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.Query;
import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class PostService extends BaseCacheService<Post, PostDTO, UUID> {

    protected PostService() {
        super(Post.class, PostDTO.class, Post.PATH);
    }

    @Override
    public PostDTO convertToDTO(Post data) {
        PostDTO postDTO = new PostDTO(data);
        postDTO.setUserId(data.getUser().getId());
        postDTO.setCatalogId(data.getCatalog().getId());
        return postDTO;
    }

    public List<?> search(int page, int size, String search) {
        String q = "from post ";
        if (search != null) {
            q += "where title like :s or content like :s ";
        }
        Query query = getEm().createNativeQuery("select CAST (id AS varchar) " + q + "order by created desc");
        if (search != null) {
            query.setParameter("s", "%" + search + "%");
        }
        return query.setFirstResult(page * size).setMaxResults(size).getResultList();
    }
}
