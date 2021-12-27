import { openConnection } from '@/database'

export default {
  namespaced: true,
  state: {
    db: null
  },
  getters: {
    get: ({ db }) => db
  },
  mutations: {
    setDB(state, value) {
      state.db = value
    }
  },
  actions: {
    async initDB({ commit }) {
      try {
        const db = await openConnection()
        commit('setDB', db)
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      }
    }
  }
}
