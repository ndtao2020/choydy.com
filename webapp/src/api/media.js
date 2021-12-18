import * as req from '@/request'

const findAllMediaByPostId = (id) => req.get(`/public/post/media?id=${id}`)

export { findAllMediaByPostId }
