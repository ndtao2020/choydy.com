import * as req from '@/request'

const session = () => req.get(`/auth/est`)
const logout = () => req.del(`/auth/est`)

export { session, logout }
