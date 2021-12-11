export default [
  {
    path: '/admin',
    component: import('@/layouts/admin'),
    children: [
      {
        path: '',
        name: 'admin.dashboard',
        meta: { auth: true, name: 'Profile' },
        component: () => import('@/views/AdminPages/Dashboard')
      },
      {
        path: 'table',
        name: 'admin.table',
        meta: { auth: true, name: 'Profile' },
        component: () => import('@/views/Apps/Social/SocialApp')
      }
    ]
  }
]
