import * as req from '@/request'

const findAllTagByPostId = (id) => req.get(`/public/post/tag?id=${id}`)

export { findAllTagByPostId }
