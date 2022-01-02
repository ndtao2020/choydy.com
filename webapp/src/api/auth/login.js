import { oauth } from '@/request'

const submit = (username, password) =>
  oauth(
    '/login',
    JSON.stringify({
      username,
      password
    })
  )

const loginBySocialNetwork = (social, credential, { uid, email, displayName, phoneNumber, photoURL, providerId }) => {
  if (!uid && !email && !social) {
    throw Error('Misinformation !')
  }
  return oauth(
    '/social',
    JSON.stringify({
      id: uid,
      providerId,
      social,
      email,
      phoneNumber,
      timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
      name: displayName || email,
      avatar: photoURL,
      credential
    })
  )
}

export { submit, loginBySocialNetwork }
