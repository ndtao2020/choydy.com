import { authPost, authDel } from '@/request'

const createLike = (id, type) => authPost(`/postlike?i=${id}&t=${type}`)
const removeLike = (id) => authDel(`/postlike?i=${id}`)

export { createLike, removeLike }
