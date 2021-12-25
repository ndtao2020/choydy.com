import * as req from '@/request'

const getMediaLink = (id, type) => `/api/public/media?i=${id}&t=${type}`
const findAllMediaByPostId = (id) => req.get(`/public/post/media?i=${id}`)

export { getMediaLink, findAllMediaByPostId }
