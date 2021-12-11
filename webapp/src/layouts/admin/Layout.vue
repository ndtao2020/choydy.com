<template>
  <div :class="[{ root: true, sidebarClose, sidebarStatic }, 'sing-dashboard']">
    <Sidebar />
    <div class="wrap">
      <Header />
      <div class="content">
        <breadcrumb-history></breadcrumb-history>
        <transition name="router-animation">
          <router-view />
        </transition>
        <footer class="contentFooter">
          Sing App Vue Dashboard Free Template - Made by
          <a href="https://flatlogic.com" rel="nofollow noopener noreferrer" target="_blank">Flatlogic</a>
        </footer>
      </div>
    </div>
  </div>
</template>

<script>
import { createNamespacedHelpers } from 'vuex'
const { mapState, mapActions } = createNamespacedHelpers('layout')
import Sidebar from './components/Sidebar'
import Header from './components/Header'
import BreadcrumbHistory from './components/BreadcrumbHistory'
import './Layout.scss'

export default {
  name: 'AdminLayout',
  components: { Sidebar, Header, BreadcrumbHistory },
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
