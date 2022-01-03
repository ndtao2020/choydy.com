import { authGet } from '@/request'

const checkLiked = (id) => authGet(`/postlike?i=${id}`)

export { checkLiked }
