import * as req from '@/request'

const url = `/public/post`

const getPosts = (page, size, search) => {
  let u = `${url}?p=${page}&s=${size}`
  if (search) {
    u += `&k=${search}`
  }
  return req.get(u)
}
const getPostById = (id) => req.get(`${url}/id?i=${id}`)

// Like
const getAllLikeTypes = () => req.get(`${url}/like/type`)
const getAllLikeByPostId = (id) => req.get(`${url}/like?i=${id}`)

export { getPosts, getPostById, getAllLikeTypes, getAllLikeByPostId }
