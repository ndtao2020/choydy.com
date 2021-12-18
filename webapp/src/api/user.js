import * as req from '@/request'

const getUserById = (id) => req.get(`/public/user?id=${id}`)

export { getUserById }
