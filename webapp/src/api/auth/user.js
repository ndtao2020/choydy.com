import { authGet } from '@/request'

const getUserById = () => authGet(`/user`)

export { getUserById }
