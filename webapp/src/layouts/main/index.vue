<template>
  <div class="wrapper">
    <sidebar />
    <NavBar />
    <right-sideBar>
      <i slot="icon" class="ri-sound-module-fill font-size-18 text-primary" />
    </right-sideBar>
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
    NavBar: () => import('./components/navbar'),
    RightSideBar: () => import('./components/rightsidebar'),
    Footer: () => import('./components/footer')
  }
}
</script>
