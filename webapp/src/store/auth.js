const KEY_SESSION = 'session'
const KEY_EXPIRES = 'expires_in'

const checkLogged = () => {
  const session = localStorage.getItem(KEY_SESSION)
  const expires = localStorage.getItem(KEY_EXPIRES)
  return session != null && expires != null
}

export default {
  namespaced: true,
  state: {
    logged: checkLogged()
  },
  getters: {
    logged: ({ logged }) => logged
  },
  mutations: {
    setLogged(state) {
      state.logged = state
    }
  },
  actions: {
    clearAuthentication({ commit }) {
      localStorage.removeItem(KEY_SESSION)
      localStorage.removeItem(KEY_EXPIRES)
      commit('setLogged', false)
    }
  }
}
