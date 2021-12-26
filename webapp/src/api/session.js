import { authGet, authDel } from '@/request'

const session = () => authGet(`/est`)
const logout = () => authDel(`/est`)

export { session, logout }
