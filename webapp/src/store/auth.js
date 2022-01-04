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
    setsession(state, obj) {
      state.session = obj
    }
  },
  actions: {
    async setAuthentication({ commit }, payload) {
      try {
        commit('setsession', parseJWT(payload))
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
        commit('setsession', null)
      }
    },
    async loadsession() {
      try {
        const data = await session()
        if (data) {
          return parseJWT(data)
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
        commit('setsession', null)
      }
    }
  }
}
