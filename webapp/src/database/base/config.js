const exp = 60 * 60 * 24 * 1000
const options = {
  keyPath: 'id'
}

const config = {
  post: {
    name: 'post',
    exp: 60 * 60 * 1000,
    options
  },
  user: {
    name: 'user',
    exp,
    options
  },
  catalog: {
    name: 'catalog',
    exp,
    options
  }
}

export default config
