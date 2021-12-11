import Vue from 'vue'
import Vuex from 'vuex'
import auth from './Auth'
import Setting from './Setting'
import layout from './layout'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    layout,
    auth,
    Setting
  },
  state: {},
  mutations: {},
  actions: {},
  getters: {},
  strict: process.env.NODE_ENV !== 'production'
})
