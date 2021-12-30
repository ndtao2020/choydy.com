<template>
  <div class="wrapper">
    <sidebar />
    <NavBar />
    <right-sideBar />
    <div class="content-page">
      <div class="container">
        <div class="row">
          <div class="col-sm-12">
            <div class="row m-0 p-0">
              <div class="col-lg-8">
                <router-view />
              </div>
              <div class="main-banner col-lg-4">
                <div class="iq-card iq-card-header">
                  <h4 slot="title" class="card-title p-3">Mạng xã hội</h4>
                  <ul class="media-story m-0 px-3 pb-1">
                    <li class="d-flex align-items-center active mb-4" @click="openLink('https://www.facebook.com/choydycom')">
                      <img src="@/assets/images/facebook/avatar.jpg" alt="story-img" width="60" height="60" />
                      <div class="stories-data ml-3">
                        <h5>ChoyDy</h5>
                        <p class="mb-0">377 Người theo dõi</p>
                      </div>
                    </li>
                    <li class="d-flex align-items-center active mb-4" @click="openLink('https://www.youtube.com/channel/UC4uxhittpSxavMAKP0-M4CQ')">
                      <img src="@/assets/images/facebook/unnamed.jpg" alt="story-img" width="60" height="60" />
                      <div class="stories-data ml-3">
                        <h5>Nóng</h5>
                        <p class="mb-0">962 Người đăng ký</p>
                      </div>
                    </li>
                  </ul>
                </div>
                <div>
                  <img
                    src="https://kinsta.com/wp-content/uploads/2020/06/half-page-1-1.png"
                    class="img-fluid rounded"
                    alt="Responsive image"
                    width="100%"
                    height="400"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <Footer />
  </div>
</template>

<script>
import '@/assets/scss/main/main.scss'

export default {
  name: 'MainLayout',
  components: {
    Sidebar: () => import('./components/Sidebar'),
    NavBar: () => import('./components/Navbar'),
    RightSideBar: () => import('./components/RightSideBar'),
    Footer: () => import('./components/footer')
  },
  methods: {
    openLink(link) {
      window.open(link, '_blank')
    }
  }
}
</script>
