import Vue from 'vue'
import VueRouter from 'vue-router'
import Nprogress from 'nprogress'
import store from '@/store'
import seo from '@/seo'
import { SESSION } from '@/constants'
// routes
import adminChildRoutes from './admin'

Vue.use(VueRouter)

// Nprogress.configure({ showSpinner: false })

const checkRole = (roles, userRole) => {
  for (const role of roles) {
    if (userRole.some((r) => r === role)) {
      return true
    }
  }
  return false
}

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/login',
      name: 'login',
      meta: { title: 'Đăng nhập' },
      component: () => import('@/views/AuthPages/Login')
    },
    ...adminChildRoutes,
    {
      path: '/post/:postid/m/:mediaid',
      component: () => import('@/views/Post')
    },
    {
      path: '/',
      component: () => import('@/layouts/main'),
      children: [
        {
          path: '',
          name: 'home',
          component: () => import('@/views/Main'),
          meta: {
            title: 'Trang chủ',
            description: 'Trang tin cập nhật những Meme hài hước, vui nhộn.'
          }
        },
        {
          path: 'catalog/:id',
          name: 'home-catalog',
          component: () => import('@/views/Main')
        },
        {
          path: 'post/:id',
          name: 'post-detail',
          component: () => import('@/views/Main/Detail')
        }
      ]
    },
    { path: '/404', name: '404', component: () => import('@/views/Pages/ErrorPage') },
    { path: '*', redirect: '/404' }
  ]
})

router.beforeEach(({ path, meta = {} }, from, next) => {
  // loading
  Nprogress.start()
  // seo
  seo(path, meta)
  //check auth
  const { auth, roles } = meta
  if (auth) {
    const exp = store.getters['auth/exp']
    if (!exp) {
      return next({ name: 'login', query: { redirect: path } })
    }
    if (exp * 1000 <= new Date().getTime()) {
      localStorage.removeItem(SESSION)
      return next({ name: 'login', query: { redirect: path } })
    }
    const userId = store.getters['auth/id']
    if (!userId) {
      return next({ name: 'login', query: { redirect: path } })
    }
    if (roles) {
      if (!checkRole(roles, store.getters['auth/roles'])) {
        return next({ name: 'login', query: { redirect: path } })
      }
    }
  }
  next()
})

router.afterEach(() => Nprogress.done())

export default router
