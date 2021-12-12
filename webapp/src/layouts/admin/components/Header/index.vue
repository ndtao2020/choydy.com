<template>
  <b-navbar class="header d-print-none app-header">
    <b-nav>
      <b-nav-item>
        <a id="barsTooltip" class="d-md-down-none px-2" href="#" @click="toggleSidebarMethod">
          <i class="las la-bars"></i>
        </a>
        <a class="fs-lg d-lg-none" href="#" @click="switchSidebarMethod">
          <i class="las la-bars"></i>
        </a>
      </b-nav-item>
    </b-nav>
    <b-nav>
      <b-form class="d-sm-down-none ml-5" inline>
        <b-form-group>
          <b-input-group class="input-group-no-border">
            <template #prepend>
              <b-input-group-text><i class="las la-search"></i></b-input-group-text>
            </template>
            <b-form-input id="search-input" placeholder="Tìm kiếm" />
          </b-input-group>
        </b-form-group>
      </b-form>
    </b-nav>
    <a class="navbarBrand d-md-none">
      <i class="fa fa-circle text-danger" />
      &nbsp; sing &nbsp;
      <i class="fa fa-circle text-primary" />
    </a>
    <b-nav class="ml-auto">
      <b-nav-item-dropdown
        class="notificationsMenu d-sm-down-none mr-2"
        menu-class="notificationsWrapper py-0 animate__animated animate__animated-fast animate__fadeIn"
        right
      >
        <template slot="button-content">
          <span class="avatar rounded-circle thumb-sm float-left mr-2">
            <img class="rounded-circle" src="https://lh3.googleusercontent.com/ogw/ADea4I6XqgDJ0gnzpP2blFAU_d88wpW2hOEhGdYlB2Sv=s64-c-mo" alt="..." />
          </span>
          <span class="px-2">Nguyễn Đình Tạo</span>
          <span class="ml-1 mr-2 circle text-white fw-bold avatar-badge">9</span>
          <i class="las la-angle-double-down px-2"></i>
        </template>
      </b-nav-item-dropdown>
      <b-nav-item-dropdown id="v-step-2" class="settingsDropdown d-sm-down-none" no-caret right>
        <template slot="button-content">
          <i class="las la-cog px-2"></i>
        </template>
        <b-dropdown-item><i class="las la-info-circle"></i> Tài khoản</b-dropdown-item>
        <b-dropdown-divider />
        <b-dropdown-item-button @click="logout"><i class="las la-sign-out-alt"></i> Đăng xuất</b-dropdown-item-button>
      </b-nav-item-dropdown>
    </b-nav>
  </b-navbar>
</template>

<script>
import { mapState, mapActions } from 'vuex'
import './index.scss'

export default {
  name: 'AdminHeader',
  computed: {
    ...mapState('layout', ['sidebarClose', 'sidebarStatic'])
  },
  methods: {
    ...mapActions('auth', ['clearAuthentication']),
    ...mapActions('layout', ['toggleSidebar', 'switchSidebar', 'changeSidebarActive']),
    switchSidebarMethod() {
      if (!this.sidebarClose) {
        this.switchSidebar(true)
        this.changeSidebarActive(null)
      } else {
        this.switchSidebar(false)
        const paths = this.$route.fullPath.split('/')
        paths.pop()
        this.changeSidebarActive(paths.join('/'))
      }
    },
    toggleSidebarMethod() {
      if (this.sidebarStatic) {
        this.toggleSidebar()
        this.changeSidebarActive(null)
      } else {
        this.toggleSidebar()
        const paths = this.$route.fullPath.split('/')
        paths.pop()
        this.changeSidebarActive(paths.join('/'))
      }
    },
    logout() {
      this.clearAuthentication()
      window.location.reload()
    }
  }
}
</script>
