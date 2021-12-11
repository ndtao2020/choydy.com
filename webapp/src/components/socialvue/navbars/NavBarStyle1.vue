<template>
  <div class="iq-top-navbar">
    <div class="iq-navbar-custom">
      <nav class="navbar navbar-expand-lg navbar-light p-0">
        <div class="iq-navbar-logo d-flex justify-content-between">
          <a href="#">
            <img :src="logo" class="img-fluid" alt="logo" width="160" height="45" />
          </a>
          <div class="iq-menu-bt align-self-center">
            <div class="wrapper-menu" @click="miniSidebar">
              <div class="main-circle"><i class="las la-bars"></i></div>
            </div>
          </div>
        </div>
        <div class="iq-search-bar">
          <form action="#" class="searchbox">
            <input type="text" class="text search-input" placeholder="Tìm kiếm..." />
            <a class="search-link" href="#"><i class="las la-search"></i></a>
          </form>
        </div>
        <b-navbar-toggle target="nav-collapse" class="mr-2">
          <i class="ri-menu-3-line"></i>
        </b-navbar-toggle>
        <b-collapse id="nav-collapse" is-nav>
          <!-- <ul class="navbar-nav ml-auto navbar-list">
            <li>
              <a href="#" class="d-flex align-items-center">
                <img
                  src="https://lh3.googleusercontent.com/ogw/ADea4I6XqgDJ0gnzpP2blFAU_d88wpW2hOEhGdYlB2Sv=s64-c-mo"
                  class="img-fluid rounded-circle"
                  alt="user"
                />
              </a>
            </li>
          </ul> -->
          <ul class="navbar-list">
            <li>
              <a href="/login" class="search-toggle iq-waves-effect d-flex align-items-center">
                Đăng nhập <i class="las la-sign-in-alt" style="font-size: 30px" />
              </a>
            </li>
          </ul>
        </b-collapse>
      </nav>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    homeURL: { type: Object, default: () => ({ name: 'layout1.dashboard' }) },
    title: { type: String, default: 'Dashboard' },
    logo: { type: String, default: require('@/assets/images/logo.png') },
    horizontal: { type: Boolean, default: false },
    items: { type: Array }
  },
  methods: {
    miniSidebar() {
      document.querySelector('.wrapper-menu').classList.toggle('open')
      document.querySelector('body').classList.toggle('sidebar-main')
    }
  }
}
</script>
