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
          <a href="https://www.facebook.com/dinhtao.nguyen.3" rel="nofollow noopener noreferrer" target="_blank">Nguyễn Đình Tạo</a>
        </footer>
      </div>
    </div>
  </div>
</template>

<script>
import { createNamespacedHelpers } from 'vuex'
const { mapState, mapActions } = createNamespacedHelpers('layout')
import './Layout.scss'

export default {
  name: 'AdminLayout',
  components: {
    Sidebar: () => import('./components/Sidebar'),
    Header: () => import('./components/Header')
  },
  computed: {
    ...mapState(['sidebarClose', 'sidebarStatic'])
  },
  created() {
    const staticSidebar = JSON.parse(localStorage.getItem('sidebarStatic'))
    if (staticSidebar) {
      this.$store.state.layout.sidebarStatic = true
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
    ...mapActions(['switchSidebar', 'handleSwipe', 'changeSidebarActive', 'toggleSidebar']),
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
