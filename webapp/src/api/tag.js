import { publicGet } from '@/request'

const findAllTagByPostId = (id) => publicGet(`/post/tag?i=${id}`)

export { findAllTagByPostId }
