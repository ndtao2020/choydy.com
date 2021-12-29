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
                Đăng nhập <img class="ml-1" src="@/assets/icons/sign-in.svg" height="20" width="20" />
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
  name: 'MainNavBar',
  methods: {
    scrollTop() {
      window.scrollTo({ top: 0, left: 0, behavior: 'smooth' })
    },
    miniSidebar() {
      document.querySelector('.wrapper-menu').classList.toggle('open')
      document.querySelector('body').classList.toggle('sidebar-main')
    }
  }
}
</script>
