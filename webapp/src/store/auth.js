import Cookies from 'js-cookie'

const KEY_SESSION = 'session'
const KEY_EXPIRES = 'expires_in'
const KEY_COOKIE = '_id'

export const getToken = () => Cookies.get(KEY_COOKIE)

const checkLogged = () => {
  const session = localStorage.getItem(KEY_SESSION)
  const expires = localStorage.getItem(KEY_EXPIRES)
  return getToken() != null && session != null && expires != null
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
      Cookies.remove(KEY_COOKIE)
      commit('setLogged', false)
    }
  }
}
