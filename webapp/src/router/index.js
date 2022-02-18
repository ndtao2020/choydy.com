import { createRouter, createWebHashHistory } from 'vue-router'
import Nprogress from 'nprogress'
import store from '@/store'
import seo from '@/seo'
// routes
import adminChildRoutes from './admin'

// Nprogress.configure({ showSpinner: false })

const checkRole = (roles, userRole) => {
  for (const role of roles) {
    if (userRole.some((r) => r === role)) {
      return true
    }
  }
  return false
}

const router = createRouter({
  mode: 'history',
  history: createWebHashHistory(process.env.BASE_URL),
  base: '/',
  routes: [
    {
      path: '/login',
      name: 'login',
      meta: { title: 'Đăng nhập' },
      component: () => import('@/views/AuthPages/Login')
    },
    ...adminChildRoutes,
    {
      path: '/verify/success',
      name: 'verify-success',
      component: () => import('@/views/AuthPages/VerifySuccess')
    },
    {
      path: '/verify/failed',
      name: 'verify-failed',
      component: () => import('@/views/AuthPages/VerifyFailed')
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
            adsense: true,
            title: 'Trang chủ'
          }
        },
        {
          path: 'catalog/:id',
          name: 'home-catalog',
          component: () => import('@/views/Main'),
          meta: {
            adsense: true
          }
        },
        {
          path: 'post/:id',
          name: 'post-detail',
          component: () => import('@/views/Main/Detail'),
          meta: {
            adsense: true
          }
        }
      ]
    },
    {
      path: '/privacy-policy',
      name: 'privacy-policy',
      component: () => import('@/views/Pages/PrivacyPolicy')
    },
    {
      path: '/terms-and-conditions',
      name: 'terms-and-conditions',
      component: () => import('@/views/Pages/TermsOfService')
    },
    { path: '/404', name: '404', component: () => import('@/views/Pages/ErrorPage') }
    // { path: '*', redirect: '/404' }
  ]
})

router.beforeEach(({ path, meta = {} }, from, next) => {
  // loading
  Nprogress.start()
  // seo
  seo(meta, path)
  //check auth
  const { auth, roles } = meta
  if (auth) {
    const logged = store.getters['auth/logged']
    if (!logged) {
      return next({ name: 'login', query: { redirect: path } })
    }
    if (roles && roles.length && !checkRole(roles, store.getters['auth/roles'])) {
      return next({ name: 'login', query: { redirect: path } })
    }
  }
  next()
})

router.afterEach(() => Nprogress.done())

export default router
