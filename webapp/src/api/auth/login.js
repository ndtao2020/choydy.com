import { oauth } from '@/request'

const submit = (username, password) =>
  oauth(
    '/login',
    JSON.stringify({
      username,
      password
    })
  )

const loginBySocialNetwork = (social, credential, user) => {
  const url = '/social'
  const timezone = Intl.DateTimeFormat().resolvedOptions().timeZone
  if (!user) {
    return oauth(url, JSON.stringify({ social, timezone, credential }))
  }
  const { uid, email, displayName, phoneNumber, photoURL, providerId } = user
  if (!uid && !email && !social) {
    throw Error('Misinformation !')
  }
  return oauth(
    url,
    JSON.stringify({
      id: uid,
      providerId,
      social,
      email,
      phoneNumber,
      timezone,
      name: displayName || email,
      avatar: photoURL,
      credential
    })
  )
}

export { submit, loginBySocialNetwork }
