const exp = 60 * 60 * 24 * 1000
const options = {
  keyPath: 'id'
}

const config = {
  post: {
    name: 'post',
    exp: 60 * 60 * 1000,
    version: 1,
    options
  },
  user: {
    name: 'user',
    exp,
    version: 1,
    options
  },
  catalog: {
    name: 'catalog',
    exp,
    version: 1,
    options
  },
  // ver 2
  postlike: {
    name: 'postlike',
    exp: 30 * 60 * 1000,
    version: 2,
    options
  }
}

export default config
