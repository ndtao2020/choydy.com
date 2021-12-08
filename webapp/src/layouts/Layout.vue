<template>
  <div>
    <div class="wrapper">
      <!-- Sidebar  -->
      <SideBarStyle1 :items="verticalMenu" />
      <!-- TOP Nav Bar -->
      <NavBarStyle1 title="Dashboard" :home-u-r-l="{ name: 'dashboard1.home' }" />
      <!-- Right Nav Bar -->
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
      <!-- TOP Nav Bar END -->
      <div id="content-page" class="content-page">
        <div class="container">
          <transition name="router-anim" :enter-active-class="`animated zoomIn`" mode="out-in" :leave-active-class="`animated zoomOut`">
            <router-view />
          </transition>
        </div>
      </div>
    </div>
    <FooterStyle1>
      <template #left>
        <li class="list-inline-item"><a href="#">Privacy Policy</a></li>
        <li class="list-inline-item"><a href="#">Terms of Use</a></li>
      </template>
      <template #right> Copyright 2020 <a href="#">SocialV</a> All Rights Reserved. </template>
    </FooterStyle1>
  </div>
</template>

<script>
import SideBarItems from '../FackApi/json/SideBar'
import { mapActions } from 'vuex'
import '@/assets/scss/style.scss'
import '@/assets/css/custom.css'

export default {
  name: 'LayoutK',
  components: {
    SideBarStyle1: () => import('@/components/socialvue/sidebars/SideBarStyle1'),
    NavBarStyle1: () => import('@/components/socialvue/navbars/NavBarStyle1'),
    RightSideBar: () => import('@/components/socialvue/rightsidebar/RightSideBar'),
    FooterStyle1: () => import('@/components/socialvue/footer/FooterStyle1')
  },
  data() {
    return {
      verticalMenu: SideBarItems
    }
  },
  methods: {
    logout() {
      localStorage.removeItem('user')
      localStorage.removeItem('access_token')
      this.$router.push({ name: 'auth1.sign-in1' })
    },
    ...mapActions({
      langChangeState: 'Setting/setLangAction'
    })
  }
}
</script>
