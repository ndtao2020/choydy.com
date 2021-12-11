import Vue from 'vue'
import VueRouter from 'vue-router'
import authChildRoutes from './auth'
// import adminChildRoutes from './admin'

/* Layouts */
const Layout = () => import('../layouts/Layout')
const Default = () => import('../layouts/BlankLayout')
const AuthLayout = () => import('../layouts/AuthLayouts/AuthLayout')
/* all routes */
const ProfileImage = () => import('../views/SocailMain/Profile/ProfileImage')
const ProfileVideo = () => import('../views/SocailMain/Profile/ProfileVideo')
const ProfileEvent = () => import('../views/SocailMain/Profile/ProfileEvent')
const FriendList = () => import('../views/SocailMain/Friends/FriendList')
const Notification = () => import('../views/SocailMain/Notifications/Notification')
const FriendRequest = () => import('../views/SocailMain/Friends/FriendRequest')
/* Extra Pages */
const ErrorPage = () => import('../views/Pages/ErrorPage')
const ComingSoon = () => import('../views/Pages/ComingSoon')
const Maintenance = () => import('../views/Pages/Maintenance')
/* User View */
const Profile = () => import('../views/User/Profile')
const ProfileEdit = () => import('../views/User/ProfileEdit')
const AddUser = () => import('../views/User/AddUser')
/* Todo */
const AccountSettings = () => import('../views/User/AccountSetting')
//
const childRoutes = (prop) => [
  {
    path: '/',
    name: prop + '.list',
    meta: { auth: true, name: 'Social App' },
    component: () => import('@/views/Apps/Social/SocialApp')
  },
  {
    path: '/profile',
    name: prop + '.profile',
    meta: { auth: true, name: 'Profile' },
    component: () => import('../views/SocailMain/Profile/Profile')
  },
  {
    path: 'friend-list',
    name: prop + '.friend-list',
    meta: { auth: true, name: 'Friend List', img: require('../assets/images/page-img/profile-bg3.jpg') },
    component: FriendList
  },
  {
    path: 'profile-image',
    name: prop + '.profile-image',
    meta: { auth: true, name: 'Your Photos', img: require('../assets/images/page-img/profile-bg5.jpg') },
    component: ProfileImage
  },
  {
    path: 'profile-video',
    name: prop + '.profile-video',
    meta: { auth: true, name: 'Profile Video', img: require('../assets/images/page-img/profile-bg9.jpg') },
    component: ProfileVideo
  },
  {
    path: 'profile-event',
    name: prop + '.profile-event',
    meta: { auth: true, name: 'Your Event', img: require('../assets/images/page-img/profile-bg6.jpg') },
    component: ProfileEvent
  },
  {
    path: 'notification',
    name: prop + '.notification',
    meta: { auth: true, name: 'Notification' },
    component: Notification
  },
  {
    path: 'friend-request',
    name: prop + '.friend-request',
    meta: { auth: true, name: 'Friend Request' },
    component: FriendRequest
  },
  {
    path: '/account-setting',
    name: 'accountSetting',
    meta: { auth: true, name: 'AccountSettings' },
    component: AccountSettings
  }
]
const pagesChildRoutes = (prop) => [
  {
    path: 'error/:code',
    name: prop + '.error',
    meta: { auth: true },
    component: ErrorPage
  },
  {
    path: 'coming-soon',
    name: prop + '.coming-soon',
    meta: { auth: true },
    component: ComingSoon
  },
  {
    path: 'maintenance',
    name: prop + '.maintenance',
    meta: { auth: true },
    component: Maintenance
  }
]
const userChildRoute = (prop) => [
  {
    path: 'profile',
    name: prop + '.profile',
    meta: { auth: true, name: 'Profile' },
    component: Profile
  },
  {
    path: 'profile-edit',
    name: prop + '.edit',
    meta: { auth: true, name: 'Edit Profile' },
    component: ProfileEdit
  },
  {
    path: 'add-user',
    name: prop + '.add',
    meta: { auth: true, name: 'Add Profile' },
    component: AddUser
  }
]

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  base: process.env.VUE_APP_BASE_URL,
  routes: [
    {
      path: '/admin',
      component: () => import('@/layouts/admin/Layout'),
      children: [
        {
          path: '',
          name: 'AnalyticsPage',
          component: () => import('@/views/AdminPages/Dashboard')
        }
      ]
    },
    {
      path: '/',
      name: 'social',
      component: Layout,
      children: childRoutes('social')
    },
    {
      path: '/auth',
      name: 'auth1',
      component: AuthLayout,
      meta: { auth: true },
      children: authChildRoutes('auth1')
    },
    {
      path: '/pages',
      name: 'pages',
      component: Default,
      meta: { auth: true },
      children: pagesChildRoutes('default')
    },
    {
      path: '/user',
      name: 'user',
      component: Layout,
      meta: { auth: true },
      children: userChildRoute('user')
    }
  ]
})
