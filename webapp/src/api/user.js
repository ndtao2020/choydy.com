import * as req from '@/request'

const getUserById = (id) => req.get(`/public/user?i=${id}`)

export { getUserById }
