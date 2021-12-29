<template>
  <div class="wrapper">
    <sidebar />
    <NavBar />
    <right-sideBar />
    <div class="content-page">
      <div class="container">
        <router-view />
      </div>
    </div>
    <Footer />
  </div>
</template>

<script>
import '@/assets/scss/main/main.scss'

export default {
  name: 'MainLayout',
  components: {
    Sidebar: () => import('./components/Sidebar'),
    NavBar: () => import('./components/Navbar'),
    RightSideBar: () => import('./components/RightSideBar'),
    Footer: () => import('./components/footer')
  }
}
</script>
