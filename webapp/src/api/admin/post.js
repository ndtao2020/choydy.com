import { adminGet, adminPost, adminDel } from '@/request'

const createPost = (body) => adminPost('/post', body)
const deletePost = (id) => adminDel(`/post?i=${id}`)

const postList = (page, size, search) => {
  let url = `/post?p=${page || 0}&s=${size || 10}`
  if (search != null) {
    url += `&search=${search}`
  }
  return adminGet(url)
}

export { createPost, deletePost, postList }
