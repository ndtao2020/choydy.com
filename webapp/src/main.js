import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'
// import i18n from './i18n'

Vue.config.productionTip = false

store.dispatch('auth/loadsession').then(async (data) => {
  if (data) {
    await store.commit('auth/setsession', data)
  }
  new Vue({
    router,
    store,
    // i18n,
    render: (h) => h(App)
  }).$mount('#app')
})

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
// Initialize Firebase
import { initializeApp } from 'firebase/app'
import { getAnalytics } from 'firebase/analytics'
import { getPerformance } from 'firebase/performance'
const app = initializeApp({
  apiKey: 'AIzaSyAwpLgkkQX3Xd3I_BpnTVSoh_GUOHvl6T0',
  authDomain: 'choydy-af42b.firebaseapp.com',
  projectId: 'choydy-af42b',
  storageBucket: 'choydy-af42b.appspot.com',
  messagingSenderId: '246592378948',
  appId: '1:246592378948:web:3d5a30af2d7dc9ee494411',
  measurementId: 'G-24R7TYP2CK'
})
if (process.env.NODE_ENV === 'production') {
  getAnalytics(app)
  getPerformance(app)
}
