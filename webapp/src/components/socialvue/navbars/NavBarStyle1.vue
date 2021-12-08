<template>
  <!-- TOP Nav Bar -->
  <div class="iq-top-navbar">
    <div class="iq-navbar-custom">
      <nav class="navbar navbar-expand-lg navbar-light p-0">
        <div class="iq-navbar-logo d-flex justify-content-between">
          <a href="#">
            <img :src="logo" class="img-fluid" alt="logo" />
            <!-- <span>SocialV</span> -->
          </a>
          <div class="iq-menu-bt align-self-center">
            <div class="wrapper-menu" @click="miniSidebar">
              <div class="main-circle"><i class="las la-bars"></i></div>
            </div>
          </div>
        </div>
        <div class="iq-search-bar">
          <form action="#" class="searchbox">
            <input type="text" class="text search-input" placeholder="Type here to search..." />
            <a class="search-link" href="#"><i class="las la-search"></i></a>
          </form>
        </div>
        <b-navbar-toggle target="nav-collapse" class="mr-2">
          <i class="ri-menu-3-line"></i>
        </b-navbar-toggle>
        <b-collapse id="nav-collapse" is-nav>
          <ul class="navbar-nav ml-auto navbar-list">
            <li>
              <a href="#" class="d-flex align-items-center">
                <img
                  src="https://lh3.googleusercontent.com/ogw/ADea4I6XqgDJ0gnzpP2blFAU_d88wpW2hOEhGdYlB2Sv=s64-c-mo"
                  class="img-fluid rounded-circle"
                  alt="user"
                />
              </a>
            </li>
          </ul>
          <ul class="navbar-list">
            <li>
              <a href="#" class="search-toggle iq-waves-effect d-flex align-items-center">
                <i class="las la-caret-down"></i>
              </a>
              <div class="iq-sub-dropdown iq-user-dropdown">
                <div class="iq-card shadow-none m-0">
                  <div class="iq-card-body p-0">
                    <div class="bg-primary p-3 line-height">
                      <h5 class="mb-0 text-white line-height">Hello Bni Cyst</h5>
                      <span class="text-white font-size-12">Available</span>
                    </div>
                    <router-link to="/" class="iq-sub-card iq-bg-primary-hover">
                      <div class="media align-items-center">
                        <div class="rounded iq-card-icon iq-bg-primary">
                          <i class="ri-file-user-line"></i>
                        </div>
                        <div class="media-body ml-3">
                          <h6 class="mb-0">My Profile</h6>
                          <p class="mb-0 font-size-12">View personal profile details.</p>
                        </div>
                      </div>
                    </router-link>
                    <router-link to="/user/profile-edit" class="iq-sub-card iq-bg-warning-hover">
                      <div class="media align-items-center">
                        <div class="rounded iq-card-icon iq-bg-warning">
                          <i class="ri-profile-line"></i>
                        </div>
                        <div class="media-body ml-3">
                          <h6 class="mb-0">Edit Profile</h6>
                          <p class="mb-0 font-size-12">Modify your personal details.</p>
                        </div>
                      </div>
                    </router-link>
                    <router-link to="/account-setting" class="iq-sub-card iq-bg-info-hover">
                      <div class="media align-items-center">
                        <div class="rounded iq-card-icon iq-bg-info">
                          <i class="ri-account-box-line"></i>
                        </div>
                        <div class="media-body ml-3">
                          <h6 class="mb-0">Account settings</h6>
                          <p class="mb-0 font-size-12">Manage your account parameters.</p>
                        </div>
                      </div>
                    </router-link>
                    <div class="d-inline-block w-100 text-center p-3">
                      <a class="bg-primary iq-sign-btn" href="#" role="button">Sign out<i class="ri-login-box-line ml-2"></i></a>
                    </div>
                  </div>
                </div>
              </div>
            </li>
          </ul>
        </b-collapse>
      </nav>
    </div>
  </div>
  <!-- TOP Nav Bar END -->
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  props: {
    homeURL: { type: Object, default: () => ({ name: 'layout1.dashboard' }) },
    title: { type: String, default: 'Dashboard' },
    logo: { type: String, default: require('@/assets/images/logo.png') },
    horizontal: { type: Boolean, default: false },
    items: { type: Array }
  },
  data() {
    return {
      globalSearch: '',
      showSearch: false,
      showMenu: false
    }
  },
  computed: {
    ...mapGetters({
      bookmark: 'Setting/bookmarkState'
    })
  },
  mounted() {
    document.addEventListener('click', this.closeSearch, true)
  },
  methods: {
    miniSidebar() {
      document.querySelector('.wrapper-menu').classList.toggle('open')
      document.querySelector('body').classList.toggle('sidebar-main')
    },
    openSearch() {
      this.showSearch = true
      this.showMenu = 'iq-show'
      this.globalSearch = ''
    },
    closeSearch(event) {
      let classList = event.target.classList
      if (!classList.contains('searchbox') && !classList.contains('search-input')) {
        this.removeClass()
      }
    },
    removeClass() {
      this.showSearch = false
      this.showMenu = ''
      this.globalSearch = ''
    }
  }
}
</script>
