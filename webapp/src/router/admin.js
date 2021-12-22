import { ADMIN } from '@/constants'

export default [
  {
    path: '/admin',
    component: () => import('@/layouts/admin/Layout'),
    children: [
      {
        path: '',
        name: 'AnalyticsPage',
        meta: { title: 'Quản trị', auth: true, roles: [ADMIN] },
        component: () => import('@/views/AdminPages/Dashboard')
      },
      {
        path: 'create-post',
        name: 'CreatePost',
        meta: { title: 'Tạo bài đăng', auth: true, roles: [ADMIN] },
        component: () => import('@/views/AdminPages/CreatePost')
      },
      {
        path: 'post-list',
        name: 'PostList',
        meta: { title: 'Danh sách bài đăng', auth: true, roles: [ADMIN] },
        component: () => import('@/views/AdminPages/PostList')
      }
    ]
  }
]
