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
  mounted() {
    // propellerads.com
    const propellerads = document.createElement('script')
    propellerads.setAttribute('async', '')
    propellerads.setAttribute('src', 'https://iclickcdn.com/tag.min.js')
    propellerads.setAttribute('data-zone', '4803945')
    document.body.appendChild(propellerads)
    // adsterra.com
    const adsterra = document.createElement('script')
    adsterra.setAttribute('type', 'text/javascript')
    adsterra.setAttribute('src', '//pl16933978.trustedcpmrevenue.com/00/12/2f/00122fa07403be8a174431b65f222f4c.js')
    document.body.appendChild(adsterra)
    // adcash.com
    const adcash = document.createElement('script')
    adcash.setAttribute('type', 'text/javascript')
    adcash.setAttribute('data-adel', 'atag')
    adcash.setAttribute('src', '//acscdn.com/script/atg.js')
    adcash.setAttribute('czid', 'sajx6isa')
    document.body.appendChild(adcash)
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
