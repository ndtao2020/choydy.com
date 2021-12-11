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
      configs.headers['Content-Type'] = 'application/json'
      if (body) {
        configs['body'] = body
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
