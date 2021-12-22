import { fetch } from 'whatwg-fetch'

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
  return fetch(`/api${url}`, configs)
    .then((res) => {
      if (res.status >= 200 && res.status < 300) {
        return Promise.resolve(res.json())
      }
      return Promise.reject(res.json())
    })
    .catch((error) => Promise.reject(error))
}

const get = (url) => config(url, 'GET')
const post = (url, body) => config(url, 'POST', body)
const put = (url, body) => config(url, 'PUT', body)
const del = (url) => config(url, 'DELETE')

const oauth = (url, body) =>
  config(url, 'POST', body, {
    Authorization: 'Basic ZjRhZWVkNTM2NzVlZTpiZ1ZrWXAzczZSZ1VrWG4ycjVhZEBmNGM2MTMhZGViMw=='
  })

export { get, post, put, del, oauth }
