import Vue from 'vue'
import Vuex from 'vuex'
import auth from './auth'
import layout from './layout'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    auth,
    layout
  },
  state: {},
  mutations: {},
  actions: {},
  getters: {},
  strict: process.env.NODE_ENV !== 'production'
})
