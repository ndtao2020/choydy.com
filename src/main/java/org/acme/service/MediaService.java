package org.acme.service;

import org.acme.base.service.BaseService;
import org.acme.model.Media;
import org.acme.model.dto.MediaDTO;

import javax.enterprise.context.ApplicationScoped;
import java.util.UUID;

@ApplicationScoped
public class MediaService extends BaseService<Media, MediaDTO, UUID> {

    protected MediaService() {
        super(Media.class, MediaDTO.class);
    }

    @Override
    public MediaDTO convertToDTO(Media data) {
        MediaDTO mediaDTO = new MediaDTO();
        mediaDTO.setPostId(data.getPost().getId());
        return mediaDTO;
    }
}
