import { publ, publicGet } from '@/request'

const getMediaLink = (id, type) => publ(`/media?i=${id}&t=${type}`)
const findAllMediaByPostId = (id) => publicGet(`/post/media?i=${id}`)

export { getMediaLink, findAllMediaByPostId }
