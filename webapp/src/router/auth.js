export default (prop) => [
  {
    path: 'sign-in1',
    name: prop + '.sign-in1',
    meta: { auth: true },
    component: () => import('../views/AuthPages/Default/SignIn1')
  },
  {
    path: 'sign-up1',
    name: prop + '.sign-up1',
    meta: { auth: true },
    component: () => import('../views/AuthPages/Default/SignUp1')
  },
  {
    path: 'password-reset1',
    name: prop + '.password-reset1',
    meta: { auth: true },
    component: () => import('../views/AuthPages/Default/RecoverPassword1')
  },
  {
    path: 'lock-screen1',
    name: prop + '.lock-screen1',
    meta: { auth: true },
    component: () => import('../views/AuthPages/Default/LockScreen1')
  },
  {
    path: 'confirm-mail1',
    name: prop + '.confirm-mail1',
    meta: { auth: true },
    component: () => import('../views/AuthPages/Default/ConfirmMail1')
  }
]
