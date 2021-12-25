import * as req from '@/request'

const createPost = (body) => req.post('/admin/post', body)
const deletePost = (id) => req.del(`/admin/post?i=${id}`)

const postList = (page, size, search) => {
  let url = `/admin/post?p=${page || 0}&s=${size || 10}`
  if (search != null) {
    url += `&search=${search}`
  }
  return req.get(url)
}

export { createPost, deletePost, postList }
