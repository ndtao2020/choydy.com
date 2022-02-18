<template>
  <div class="wrapper">
    <sidebar />
    <NavBar />
    <div class="right-sidebar-mini">
      <div class="right-sidebar-panel p-0">
        <div class="iq-card shadow-none">
          <div ref="adsbygoog1" class="p-0" />
        </div>
      </div>
    </div>
    <div class="content-page">
      <div class="container">
        <div class="row">
          <div class="col-sm-12">
            <div class="row m-0 p-0">
              <div class="col-lg-8">
                <router-view />
              </div>
              <div class="col-lg-4 main-banner">
                <div class="iq-card">
                  <h4 class="card-title p-3">Mạng xã hội</h4>
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
                <div ref="wrapads" style="width: inherit; max-width: 450px" :class="{ 'sticky-banner': show }">
                  <div ref="adsbygoog2" />
                  <div ref="adsbygoog3" />
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
import { GOOGLE_AD_CLIENT } from '@/constants'
import '@/assets/scss/main/main.scss'

export default {
  name: 'MainLayout',
  components: {
    Sidebar: () => import('./components/Sidebar'),
    NavBar: () => import('./components/Navbar'),
    Footer: () => import('./components/Footer')
  },
  data() {
    return {
      observer: null,
      show: false
    }
  },
  created() {
    this.observer = new IntersectionObserver(this.onElementObserved, {
      root: null,
      rootMargin: '0px',
      threshold: this.buildThresholdList()
    })
  },
  mounted() {
    const { adsbygoog1, wrapads, adsbygoog2, adsbygoog3 } = this.$refs
    // if (process.env.NODE_ENV === 'production') {
    // window.adsbygoogle.push({})
    // window.adsbygoogle.push({})
    // window.adsbygoogle.push({})
    // ================ GG Adsense 1 ================
    if (adsbygoog1) {
      // script
      const script = document.createElement('script')
      script.setAttribute('async', '')
      script.setAttribute('src', `https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js`)
      script.setAttribute('crossorigin', 'anonymous')
      adsbygoog1.appendChild(script)
      // ins
      const ins = document.createElement('ins')
      ins.setAttribute('class', 'adsbygoogle')
      ins.setAttribute('style', `display: inline-block; width: 260px; height: 900px`)
      ins.setAttribute('data-ad-client', GOOGLE_AD_CLIENT)
      ins.setAttribute('data-ad-slot', '5910072739')
      adsbygoog1.appendChild(ins)
      // script2
      const script2 = document.createElement('script')
      script2.text = `(adsbygoogle = window.adsbygoogle || []).push({});`
      adsbygoog1.appendChild(script2)
    }
    // ================ GG Adsense 2 ================
    if (adsbygoog2) {
      // script
      const script = document.createElement('script')
      script.setAttribute('async', '')
      script.setAttribute('src', `https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js`)
      script.setAttribute('crossorigin', 'anonymous')
      adsbygoog2.appendChild(script)
      // ins
      const ins = document.createElement('ins')
      ins.setAttribute('class', 'adsbygoogle')
      ins.setAttribute('style', `display: block`)
      ins.setAttribute('data-ad-client', GOOGLE_AD_CLIENT)
      ins.setAttribute('data-ad-slot', '7686420346')
      ins.setAttribute('data-ad-format', 'auto')
      ins.setAttribute('data-full-width-responsive', 'true')
      adsbygoog2.appendChild(ins)
      // script2
      const script2 = document.createElement('script')
      script2.text = `(adsbygoogle = window.adsbygoogle || []).push({});`
      adsbygoog2.appendChild(script2)
    }
    // ================ GG Adsense 3 ================
    if (adsbygoog3) {
      // script
      const script = document.createElement('script')
      script.setAttribute('async', '')
      script.setAttribute('src', `https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js`)
      script.setAttribute('crossorigin', 'anonymous')
      adsbygoog3.appendChild(script)
      // ins
      const ins = document.createElement('ins')
      ins.setAttribute('class', 'adsbygoogle')
      ins.setAttribute('style', `display: block`)
      ins.setAttribute('data-ad-client', GOOGLE_AD_CLIENT)
      ins.setAttribute('data-ad-slot', '2856340463')
      ins.setAttribute('data-ad-format', 'auto')
      ins.setAttribute('data-full-width-responsive', 'true')
      adsbygoog3.appendChild(ins)
      // script2
      const script2 = document.createElement('script')
      script2.text = `(adsbygoogle = window.adsbygoogle || []).push({});`
      adsbygoog3.appendChild(script2)
    }
    // wrapads
    this.observer.observe(wrapads)
    // envent
    window.addEventListener('scroll', this.onHandleScroll)
  },
  beforeDestroy() {
    window.removeEventListener('scroll', this.onHandleScroll)
  },
  methods: {
    openLink(link) {
      window.open(link, '_blank')
    },
    onHandleScroll() {
      const scroll = document.documentElement.scrollTop
      if (scroll === 0 || scroll <= 50) {
        this.show = false
        return
      }
    },
    onElementObserved(entries) {
      if (this.show === false && entries[0].intersectionRatio !== 1) {
        this.show = true
      }
    },
    buildThresholdList() {
      let thresholds = []
      let numSteps = 40
      for (let i = 1.0; i <= numSteps; i++) {
        let ratio = i / numSteps
        thresholds.push(ratio)
      }
      thresholds.push(0)
      return thresholds
    }
  }
}
</script>
