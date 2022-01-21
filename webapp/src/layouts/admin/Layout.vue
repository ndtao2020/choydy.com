<template>
  <div :class="[{ root: true, sidebarClose, sidebarStatic }, 'sing-dashboard']">
    <Sidebar />
    <div class="wrap">
      <Header />
      <div class="content">
        <transition name="router-animation">
          <router-view />
        </transition>
        <footer class="contentFooter">
          © Copyright 2017 - 2022
          <a
            href="https://www.trustedcpmrevenue.com/xtaxrk5nsc?key=1d5db332bdb4be45d5bbfdbcbb7b145a"
            rel="nofollow noopener noreferrer"
            target="_blank"
            >Nguyễn Đình Tạo</a
          >
        </footer>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue'
import { mapState, mapActions } from 'vuex'
import './Layout.scss'

export default {
  name: 'AdminLayout',
  components: {
    Sidebar: () => import('./components/Sidebar'),
    Header: () => import('./components/Header')
  },
  computed: {
    ...mapState('layout', ['sidebarClose', 'sidebarStatic'])
  },
  created() {
    Vue.use(BootstrapVue)
    const staticSidebar = JSON.parse(localStorage.getItem('sidebarStatic'))
    if (staticSidebar) {
      this.setSidebarStatic(true)
    } else if (!this.sidebarClose) {
      setTimeout(() => {
        this.switchSidebar(true)
        this.changeSidebarActive(null)
      }, 2500)
    }
    this.handleWindowResize()
    window.addEventListener('resize', this.handleWindowResize)
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.handleWindowResize)
  },
  methods: {
    ...mapActions('layout', ['setSidebarStatic', 'switchSidebar', 'handleSwipe', 'changeSidebarActive', 'toggleSidebar']),
    handleWindowResize() {
      const width = window.innerWidth
      if (width <= 768 && this.sidebarStatic) {
        this.toggleSidebar()
        this.changeSidebarActive(null)
      }
    }
  }
}
</script>
