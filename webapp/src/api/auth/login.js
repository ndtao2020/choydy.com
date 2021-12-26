import { oauth } from '@/request'

const submit = (username, password) =>
  oauth(
    '/login',
    JSON.stringify({
      username,
      password
    })
  )

export { submit }
