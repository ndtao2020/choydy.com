<template>
  <div>
    <div class="wrapper">
      <sidebar />
      <NavBar />
      <RightSideBar toggle-class="top-50 setting-toggle iq-card">
        <i slot="icon" class="ri-sound-module-fill font-size-18 text-primary" />
      </RightSideBar>
      <div
        v-if="
          $route.name == 'social.friend-list' ||
          $route.name == 'social.group' ||
          $route.name == 'social.profile-image' ||
          $route.name == 'social.profile-video' ||
          $route.name == 'social.profile-event' ||
          $route.name == 'social.birthday' ||
          $route.name == 'social.music'
        "
        class="header-for-bg"
      >
        <div class="background-header position-relative">
          <img :src="$route.meta.img" class="img-fluid w-100" alt="header-bg" />
          <div class="title-on-header">
            <div class="data-block">
              <h2>{{ $route.meta.name }}</h2>
            </div>
          </div>
        </div>
      </div>
      <div id="content-page" class="content-page">
        <div class="container">
          <router-view />
        </div>
      </div>
    </div>
    <Footer />
  </div>
</template>

<script>
import '@/assets/scss/style.scss'
import '@/assets/css/custom.css'

export default {
  name: 'MainLayout',
  components: {
    Sidebar: () => import('./components/sidebar'),
    NavBar: () => import('./components/navbar'),
    RightSideBar: () => import('./components/rightsidebar'),
    Footer: () => import('./components/footer')
  }
}
</script>
