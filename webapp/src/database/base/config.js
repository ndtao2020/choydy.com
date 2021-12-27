const config = {
  post: {
    name: 'post',
    exp: 60 * 60 * 24 * 7 * 1000,
    options: {
      keyPath: 'id'
    }
  },
  user: {
    name: 'user',
    exp: 60 * 60 * 24 * 7 * 1000,
    options: {
      keyPath: 'id'
    }
  },
  catalog: {
    name: 'catalog',
    exp: 60 * 60 * 24 * 7 * 1000,
    options: {
      keyPath: 'id'
    }
  }
}

export default config
