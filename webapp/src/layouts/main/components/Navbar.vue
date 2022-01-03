<template>
  <div class="iq-top-navbar">
    <div class="iq-navbar-custom">
      <nav class="navbar navbar-expand-lg navbar-light p-0">
        <div class="iq-navbar-logo d-flex justify-content-between">
          <div class="align-self-center">
            <router-link to="/">
              <img src="@/assets/images/logo.png" class="img-fluid" alt="logo" width="160" height="45" @click="scrollTop" />
            </router-link>
          </div>
          <div class="iq-menu-bt align-self-center">
            <div class="wrapper-menu" @click="miniSidebar">
              <div class="main-circle">
                <img src="@/assets/icons/menu.svg" height="25" width="25" />
              </div>
            </div>
          </div>
        </div>
        <div class="iq-search-bar">
          <form action="#" class="searchbox">
            <input type="text" class="text search-input" placeholder="Tìm kiếm..." />
            <a class="search-link" href="#">
              <img src="@/assets/icons/search.svg" height="25" width="25" />
            </a>
          </form>
        </div>
        <b-navbar-toggle target="nav-collapse" class="mr-2">
          <img src="@/assets/icons/arrow-down.svg" height="20" width="20" />
        </b-navbar-toggle>
        <b-collapse id="nav-collapse" is-nav>
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
              <a href="/login" class="search-toggle iq-waves-effect d-flex align-items-center">
                Đăng nhập <img class="ml-2" src="@/assets/icons/lock.svg" height="20" width="20" />
              </a>
            </li>
          </ul>
        </b-collapse>
      </nav>
    </div>
  </div>
</template>

<script>
import Nprogress from 'nprogress'
import { mapGetters, mapActions } from 'vuex'
import { getUserById } from '@/api/user'
import { BCollapse } from 'bootstrap-vue/src/components/collapse'
import { BNavbarToggle } from 'bootstrap-vue/src/components/navbar'

export default {
  name: 'MainNavBar',
  components: {
    BCollapse,
    BNavbarToggle
  },
  data() {
    return {
      loading: false,
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
