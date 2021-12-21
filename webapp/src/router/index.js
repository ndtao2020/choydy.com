import Vue from 'vue'
import VueRouter from 'vue-router'
import Nprogress from 'nprogress'
import store from '@/store'
// routes
import adminChildRoutes from './admin'

Vue.use(VueRouter)

const keyMeta = `FvxcFbL1BSizNhO2svY`

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
          component: () => import('@/views/Apps/Social/SocialApp'),
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

router.afterEach(() => Nprogress.done())

export default router
