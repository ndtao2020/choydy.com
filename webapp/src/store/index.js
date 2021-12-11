import Vue from 'vue'
import Vuex from 'vuex'
import Setting from './Setting/index'
import layout from './layout'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    layout,
    Setting
  },
  state: {},
  mutations: {},
  actions: {},
  getters: {},
  strict: process.env.NODE_ENV !== 'production'
})
