import * as req from '@/request'

const createPost = (body) => req.post('/admin/post', body)

export { createPost }
