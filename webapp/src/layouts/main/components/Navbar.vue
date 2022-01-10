<template>
  <div class="iq-top-navbar">
    <nav class="navbar navbar-expand-lg p-0">
      <div class="iq-navbar-logo d-flex justify-content-between">
        <div class="align-self-center">
          <router-link to="/">
            <img src="@/assets/images/logo.png" class="full-logo" alt="logo" width="160" height="45" @click="scrollTop" />
            <img src="@/assets/images/short.png" class="short-logo" alt="logo" width="35" height="35" @click="scrollTop" />
          </router-link>
        </div>
        <div class="iq-menu-bt align-self-center">
          <div class="wrapper-menu" @click="miniSidebar">
            <img src="@/assets/icons/menu.svg" height="25" width="25" />
          </div>
        </div>
      </div>
      <!-- <div class="iq-search-bar d-flex justify-content-between">
        <input type="text" class="text search-input" placeholder="Tìm kiếm..." />
        <a class="search-link" href="#">
          <img src="@/assets/icons/search.svg" height="25" width="25" />
        </a>
      </div> -->
      <button class="navbar-toggler mr-1 collapsed" @click="showNavbar = !showNavbar">
        <img src="@/assets/icons/arrow-down.svg" height="20" width="20" />
      </button>
      <div id="nav-collapse" :class="['navbar-collapse collapse', { show: showNavbar }]" :style="{ display: showNavbar ? undefined : 'none' }">
        <ul v-if="logged" class="navbar-list" style="cursor: pointer">
          <li>
            <a href="#" class="d-flex align-items-center">
              <img :src="user[1]" class="rounded-circle" alt="user" height="35" width="35" />
            </a>
          </li>
          <li>{{ user[0] }}</li>
          <li><img class="ml-3" src="@/assets/icons/log-out.svg" height="20" width="20" @click="logout" /></li>
        </ul>
        <ul v-else class="navbar-list">
          <li>
            <router-link to="/login" class="search-toggle d-flex align-items-center">
              Đăng nhập <img class="ml-2" src="@/assets/icons/lock.svg" height="20" width="20" />
            </router-link>
          </li>
        </ul>
      </div>
    </nav>
  </div>
</template>

<script>
import Nprogress from 'nprogress'
import { mapGetters, mapActions } from 'vuex'
import { getUserById } from '@/api/user'

export default {
  name: 'MainNavBar',
  data() {
    return {
      loading: false,
      showNavbar: false,
      user: []
    }
  },
  computed: {
    ...mapGetters('auth', ['logged', 'id'])
  },
  mounted() {
    if (this.logged) {
      this.fetchUserData()
    }
  },
  methods: {
    ...mapActions('auth', ['clearAuthentication']),
    async fetchUserData() {
      this.loading = true
      try {
        this.user = await getUserById(this.id)
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      } finally {
        this.loading = false
      }
    },
    scrollTop() {
      window.scrollTo({ top: 0, left: 0, behavior: 'smooth' })
    },
    miniSidebar() {
      document.querySelector('.wrapper-menu').classList.toggle('open')
      document.querySelector('body').classList.toggle('sidebar-main')
    },
    async logout() {
      Nprogress.start()
      try {
        await this.clearAuthentication()
        window.location.reload()
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
        window.location.reload()
      } finally {
        Nprogress.done()
      }
    }
  }
}
</script>
