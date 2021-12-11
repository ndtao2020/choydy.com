<template>
  <div class="sidebar-wrapper">
    <nav :class="{ sidebar: true, sidebarStatic, sidebarOpened }" @mouseenter="sidebarMouseEnter" @mouseleave="sidebarMouseLeave">
      <header class="logo">
        <router-link to="/app/dashboard"><img src="@/assets/images/logo-w.png" alt="logo" /></router-link>
      </header>
      <h5 class="navTitle first">Menu</h5>
      <ul class="nav">
        <NavLink :active-item="activeItem" header="Thống kê" link="/admin" icon-name="las la-home" index="dashboard" is-header />
        <NavLink :active-item="activeItem" header="Bài đã đăng" link="/app/tables" icon-name="lab la-blogger" index="tables" is-header />
        <NavLink
          :active-item="activeItem"
          header="Danh mục"
          link="/app/components"
          icon-name="las la-clipboard-check"
          index="components"
          :children-links="[
            { header: 'Sex', link: '/app/components/charts' },
            { header: 'Tình dục', link: '/app/components/icons' },
            { header: 'Hentai', link: '/app/components/maps' }
          ]"
        />
      </ul>
      <h5 class="navTitle">Dung lượng</h5>
      <div class="sidebarAlerts">
        <b-alert v-for="alert in alerts" :key="alert.id" class="sidebarAlert" variant="transparent" show dismissible>
          <span>{{ alert.title }}</span>
          <br />
          <b-progress class="sidebarProgress progress-xs mt-1" :variant="alert.color" :value="alert.value" :max="100" />
          <small>{{ alert.footer }}</small>
        </b-alert>
      </div>
    </nav>
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex'
import isScreen from '@/core/screenHelper'
import './Sidebar.scss'

export default {
  name: 'AdminSidebar',
  components: { NavLink: () => import('./NavLink/NavLink') },
  data() {
    return {
      alerts: [
        {
          id: 0,
          title: 'Hình ảnh',
          value: 15,
          footer: 'Calculating x-axis bias... 65%',
          color: 'danger'
        },
        {
          id: 1,
          title: 'Video',
          value: 20,
          footer: 'Provide required notes',
          color: 'primary'
        }
      ]
    }
  },
  computed: {
    ...mapState('layout', {
      sidebarStatic: (state) => state.sidebarStatic,
      sidebarOpened: (state) => !state.sidebarClose,
      activeItem: (state) => state.sidebarActiveElement
    })
  },
  created() {
    this.setActiveByRoute()
  },
  methods: {
    ...mapActions('layout', ['changeSidebarActive', 'switchSidebar']),
    setActiveByRoute() {
      const paths = this.$route.fullPath.split('/')
      paths.pop()
      this.changeSidebarActive(paths.join('/'))
    },
    sidebarMouseEnter() {
      if (!this.sidebarStatic && (isScreen('lg') || isScreen('xl'))) {
        this.switchSidebar(false)
        this.setActiveByRoute()
      }
    },
    sidebarMouseLeave() {
      if (!this.sidebarStatic && (isScreen('lg') || isScreen('xl'))) {
        this.switchSidebar(true)
        this.changeSidebarActive(null)
      }
    }
  }
}
</script>
