import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'
import i18n from './i18n'

Vue.config.productionTip = false

store.dispatch('auth/loadSession').then(async (data) => {
  await store.commit('auth/setSession', data)
  new Vue({
    router,
    store,
    i18n,
    render: (h) => h(App)
  }).$mount('#app')
})

import { initializeApp } from 'firebase/app'
import { getAnalytics } from 'firebase/analytics'
import { getPerformance } from 'firebase/performance'
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
// Initialize Firebase
const app = initializeApp({
  apiKey: 'AIzaSyD-W3th_NcH0k1cU4PSlz6QRs8R1uVtf1c',
  authDomain: 'choydy-2fd83.firebaseapp.com',
  projectId: 'choydy-2fd83',
  storageBucket: 'choydy-2fd83.appspot.com',
  messagingSenderId: '951491626953',
  appId: '1:951491626953:web:ab29e2fb52e2c5ed9a4a18',
  measurementId: 'G-W5CF335BXX'
})
getAnalytics(app)
if (process.env.NODE_ENV === 'production') {
  getPerformance(app)
}
