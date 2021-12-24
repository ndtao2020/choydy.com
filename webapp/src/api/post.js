import * as req from '@/request'

const url = `/public/post`

const getPosts = () => req.get(url)
const getPostById = (id) => req.get(`${url}/id?id=${id}`)

// Like
const getAllLikeTypes = () => req.get(`${url}/like/type`)
const getAllLikeByPostId = (id) => req.get(`${url}/like?id=${id}`)

export { getPosts, getPostById, getAllLikeTypes, getAllLikeByPostId }
