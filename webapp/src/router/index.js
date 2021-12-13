import Vue from 'vue'
import VueRouter from 'vue-router'
import Nprogress from 'nprogress'
import store from '@/store'
// routes
import adminChildRoutes from './admin'

Vue.use(VueRouter)

Nprogress.configure({ showSpinner: false })

const router = new VueRouter({
  mode: 'history',
  base: process.env.VUE_APP_BASE_URL,
  routes: [
    {
      path: '/login',
      name: 'login',
      meta: { title: 'Đăng nhập' },
      component: () => import('@/views/AuthPages/Login')
    },
    ...adminChildRoutes,
    {
      path: '/',
      component: () => import('@/layouts/main'),
      children: [
        {
          path: '',
          name: 'home',
          meta: { title: 'Trang chủ' },
          component: () => import('@/views/Apps/Social/SocialApp')
        }
      ]
    },
    { path: '/404', name: '404', component: () => import('@/views/Pages/ErrorPage') },
    { path: '*', redirect: '/404' }
  ]
})

router.beforeEach(({ path, meta = {} }, from, next) => {
  Nprogress.start()
  const { auth } = meta
  if (auth) {
    const logged = store.getters['auth/logged']
    if (!logged) {
      next({ name: 'login', query: { redirect: path } })
      return
    }
  }
  next()
})

router.afterEach((to) => {
  // Use next tick to handle router history correctly
  // see: https://github.com/vuejs/vue-router/issues/914#issuecomment-384477609
  Vue.nextTick(() => {
    document.title = `${to.meta.title} | ChoyDy.Com - Meme hài hước`
    Nprogress.done()
  })
})

export default router
