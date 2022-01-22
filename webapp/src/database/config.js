const exp = 60 * 60 * 24 * 3 * 1000
const options = {
  keyPath: 'id'
}

const config = {
  // ver 1
  post: {
    exp,
    version: 1,
    options
  },
  user: {
    exp: 60 * 60 * 24 * 7 * 1000,
    version: 1,
    options
  },
  catalog: {
    exp: 60 * 60 * 24 * 7 * 1000,
    version: 1,
    options
  },
  // ver 2
  postlike: {
    exp: 60 * 60 * 2 * 1000,
    version: 2,
    options
  }
}

export default config
