import { publicGet } from '@/request'

const getUserById = (id) => publicGet(`/user?i=${id}`)

export { getUserById }
