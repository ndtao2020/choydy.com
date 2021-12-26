import Vue from 'vue'
import VueRouter from 'vue-router'
import Nprogress from 'nprogress'
import store from '@/store'
import { SESSION } from '@/constants'
// routes
import adminChildRoutes from './admin'

Vue.use(VueRouter)

const keyMeta = `FvxcFbL1BSizNhO2svY`

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
      path: '/',
      component: () => import('@/layouts/main'),
      children: [
        {
          path: '',
          name: 'home',
          component: () => import('@/views/Main'),
          meta: {
            title: 'Trang chủ',
            metaTags: [
              {
                name: 'description',
                content: 'Trang tin cập nhật những Meme hài hước, vui nhộn.'
              },
              {
                name: 'og:title',
                content: 'Trang chủ | ChoyDy.Com - Meme hài hước'
              },
              {
                property: 'og:description',
                content: 'Trang tin cập nhật những Meme hài hước, vui nhộn.'
              }
            ]
          }
        },
        {
          path: 'catalog/:id',
          name: 'home-catalog',
          component: () => import('@/views/Main'),
          meta: {
            title: 'Danh mục',
            metaTags: [
              {
                name: 'description',
                content: 'Trang tin cập nhật những Meme hài hước, vui nhộn.'
              },
              {
                name: 'og:title',
                content: 'Trang chủ | ChoyDy.Com - Meme hài hước'
              },
              {
                property: 'og:description',
                content: 'Trang tin cập nhật những Meme hài hước, vui nhộn.'
              }
            ]
          }
        }
      ]
    },
    { path: '/404', name: '404', component: () => import('@/views/Pages/ErrorPage') },
    { path: '*', redirect: '/404' }
  ]
})

router.beforeEach(({ path, matched, meta = {} }, from, next) => {
  // loading
  Nprogress.start()
  // set up title
  document.title = `${meta.title || '404'} | ChoyDy.Com - Meme hài hước`
  // set up meta
  const nearestWithMeta = matched
    .slice()
    .reverse()
    .find((r) => r.meta && r.meta.metaTags)
  // Turn the meta tag definitions into actual elements in the head.
  // Remove any stale meta tags from the document using the key attribute we set below.
  Array.from(document.querySelectorAll(`[${keyMeta}]`)).map((el) => el.parentNode.removeChild(el))
  nearestWithMeta &&
    nearestWithMeta.meta.metaTags
      .map((tagDef) => {
        const tag = document.createElement('meta')
        Object.keys(tagDef).forEach((key) => tag.setAttribute(key, tagDef[key]))
        tag.setAttribute(keyMeta, '')
        return tag
      })
      // Add the meta tags to the document head.
      .forEach((tag) => document.head.appendChild(tag))
  //check auth
  const { auth, roles } = meta
  if (auth) {
    // const logged = store.getters['auth/logged']
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
