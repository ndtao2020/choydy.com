export default [
  {
    path: '/admin',
    component: () => import('@/layouts/admin/Layout'),
    children: [
      {
        path: '',
        name: 'AnalyticsPage',
        meta: { title: 'Quản trị', auth: true },
        component: () => import('@/views/AdminPages/Dashboard')
      },
      {
        path: 'create',
        name: 'CreatePost',
        meta: { title: 'Tạo bài đăng', auth: true },
        component: () => import('@/views/AdminPages/CreatePost')
      }
    ]
  }
]
