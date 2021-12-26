import { publicGet } from '@/request'

const url = `/post`

const getPosts = (page, size, catalogId, search) => {
  let u = `${url}?p=${page}&s=${size}`
  if (catalogId) {
    u += `&c=${catalogId}`
  }
  if (search) {
    u += `&k=${search}`
  }
  return publicGet(u)
}
const getPostById = (id) => publicGet(`${url}/id?i=${id}`)

// Like
const getAllLikeTypes = () => publicGet(`${url}/like/type`)
const getAllLikeByPostId = (id) => publicGet(`${url}/like?i=${id}`)

export { getPosts, getPostById, getAllLikeTypes, getAllLikeByPostId }
