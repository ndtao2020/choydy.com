import * as req from '@/request'

const findAllTagByPostId = (id) => req.get(`/public/post/tag?i=${id}`)

export { findAllTagByPostId }
