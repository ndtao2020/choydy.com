import { fetch } from 'whatwg-fetch'

const PREFIX = '/api'

const OAUTH = '/o'
const PUBLIC = '/p'
const AUTH = '/u'
const ADMIN = '/a'
// const EDITOR = '/e'

const config = (url, method, body, headers = {}) => {
  let configs = {
    method,
    credentials: 'same-origin', // <-- includes cookies in the request
    headers: {
      ...headers,
      Accept: 'application/json'
    }
  }
  if (method !== 'GET') {
    if (method === 'POST' || method === 'PUT' || method === 'PATCH') {
      let isJson = true
      if (body) {
        configs['body'] = body
        if (body.constructor.name === 'FormData') {
          isJson = false
        }
      }
      if (isJson) {
        configs.headers['Content-Type'] = 'application/json'
      }
    }
  }
  return fetch(`${PREFIX}${url}`, configs)
    .then((res) => {
      if (res.status >= 200 && res.status < 300) {
        const type = res.headers.get('Content-Type')
        if (type === 'application/json') {
          return Promise.resolve(res.json())
        }
        // if (type === 'text/plain' || type === 'text/plain;charset=UTF-8') {
        //   return Promise.resolve(res.text())
        // }
        return Promise.resolve(res.text())
      }
      return Promise.reject(res.json())
    })
    .catch((error) => Promise.reject(error))
}

// Public
const publicGet = (url) => config(PUBLIC + url, 'GET')
const publicPost = (url) => config(PUBLIC + url, 'POST')

// Auth
const authGet = (url) => config(AUTH + url, 'GET')
const authPost = (url, body) => config(AUTH + url, 'POST', body)
const authPut = (url, body) => config(AUTH + url, 'PUT', body)
const authDel = (url) => config(AUTH + url, 'DELETE')

// Admin
const adminGet = (url) => config(ADMIN + url, 'GET')
const adminPost = (url, body) => config(ADMIN + url, 'POST', body)
const adminPut = (url, body) => config(ADMIN + url, 'PUT', body)
const adminDel = (url) => config(ADMIN + url, 'DELETE')

const oauth = (url, body) =>
  config(OAUTH + url, 'POST', body, {
    Authorization: 'Basic ZjRhZWVkNTM2NzVlZTpiZ1ZrWXAzczZSZ1VrWG4ycjVhZEBmNGM2MTMhZGViMw=='
  })

export {
  // Oauth
  oauth,
  // Public
  publicGet,
  publicPost,
  // Auth
  authGet,
  authPost,
  authPut,
  authDel,
  // Admin
  adminGet,
  adminPost,
  adminPut,
  adminDel
}
