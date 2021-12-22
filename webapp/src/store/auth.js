import { SESSION } from '@/constants'
import { logout } from '@/api/session'

const getSession = () => {
  const session = localStorage.getItem(SESSION)
  if (session) {
    try {
      return JSON.parse(session)
    } catch (error) {
      // eslint-disable-next-line no-console
      console.log(error)
    }
  }
  return null
}

export default {
  namespaced: true,
  state: {
    session: getSession()
  },
  getters: {
    logged: ({ session }) => session != null,
    exp: ({ session }) => session != null && session.exp,
    id: ({ session }) => session != null && session.a,
    roles: ({ session }) => session != null && session.b
  },
  mutations: {
    setSession(state) {
      state.session = state
    }
  },
  actions: {
    setAuthentication({ commit }, { access_token }) {
      try {
        const [, payloadData] = access_token.split('.')
        localStorage.setItem(SESSION, Buffer.from(payloadData, 'base64'))
        commit('setSession', getSession())
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
        localStorage.removeItem(SESSION)
        commit('setSession', null)
      }
    },
    async clearAuthentication({ commit }) {
      try {
        await logout()
      } catch (error) {
        localStorage.removeItem(SESSION)
        // eslint-disable-next-line no-console
        console.log(error)
      } finally {
        localStorage.removeItem(SESSION)
        commit('setSession', null)
      }
    }
  }
}
