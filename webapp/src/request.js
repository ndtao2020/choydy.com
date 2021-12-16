import { fetch } from 'whatwg-fetch'
import { getToken } from '@/store/auth'

const config = (url, method, body, headers = {}) => {
  const token = getToken()
  let configs = {
    method,
    credentials: 'same-origin', // <-- includes cookies in the request
    headers: {
      ...headers,
      Accept: 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {})
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
    Authorization: 'Basic ZjhhNjE5MTMtOWQ4OS00ZjBlLTgwOTAtNGFlZWQ1MzY3NWVlOmJnVmtZcDNzNlJnVWtYbjJyNWFkQGY0YzYxMyFkZWIz'
  })

export { get, post, put, del, oauth }
