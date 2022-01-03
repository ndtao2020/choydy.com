import { session, logout } from '@/api/session'

const parseJWT = (payloadData) => JSON.parse(Buffer.from(payloadData, 'base64'))

export default {
  namespaced: true,
  state: {
    session: null
  },
  getters: {
    logged: ({ session }) => session !== null,
    exp: ({ session }) => session !== null && session.exp,
    id: ({ session }) => session !== null && session.a,
    roles: ({ session }) => session !== null && session.b
  },
  mutations: {
    setSession(state, obj) {
      state.session = obj
    }
  },
  actions: {
    async setAuthentication({ commit }, payload) {
      try {
        commit('setSession', parseJWT(payload))
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
        commit('setSession', null)
      }
    },
    async loadSession() {
      try {
        const data = await session()
        if (data && data.i) {
          return parseJWT(data.i)
        }
      } catch (error) {
        return null
      }
      return null
    },
    async clearAuthentication({ commit }) {
      try {
        await logout()
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      } finally {
        commit('setSession', null)
      }
    }
  }
}
