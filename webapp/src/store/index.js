import { createStore } from 'vuex'
import auth from './auth'
import database from './database'
import layout from './layout'

export default createStore({
  modules: {
    auth,
    database,
    layout
  },
  state: {},
  mutations: {},
  actions: {},
  getters: {},
  strict: process.env.NODE_ENV !== 'production'
})
