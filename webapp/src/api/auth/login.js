import * as req from '../../request'

const submit = (username, password) =>
  req.oauth(
    '/oauth/login',
    JSON.stringify({
      username,
      password
    })
  )

export { submit }
