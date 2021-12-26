<template>
  <b-row>
    <b-col sm="12">
      <b-row class="m-0 p-0">
        <b-col lg="8">
          <social-post v-for="(id, index) in posts" :key="index" :post-id="id" />
        </b-col>
        <b-col lg="4">
          <iq-card>
            <h4 slot="title" class="card-title">Mạng xã hội</h4>
            <template #body>
              <ul class="media-story m-0 p-0">
                <li class="d-flex align-items-center active mb-4">
                  <img src="@/assets/images/facebook/unnamed.jpg" alt="story-img" width="60" height="60" />
                  <div class="stories-data ml-3">
                    <h5>Nóng</h5>
                    <p class="mb-0">962 Người đăng ký</p>
                  </div>
                </li>
                <li class="d-flex align-items-center active mb-4" @click="openLink">
                  <img src="@/assets/images/facebook/avatar.jpg" alt="story-img" width="60" height="60" />
                  <div class="stories-data ml-3">
                    <h5>Dyn Kye</h5>
                    <p class="mb-0">377 Người theo dõi</p>
                  </div>
                </li>
              </ul>
              <b-link class="btn btn-danger d-block mt-3" href="https://www.youtube.com/channel/UC4uxhittpSxavMAKP0-M4CQ" target="_blank">
                Xem chi tiết
              </b-link>
            </template>
          </iq-card>
          <iq-card>
            <h4 slot="title" class="card-title">Quảng cáo</h4>
            <template #body>
              <img
                src="https://i.pinimg.com/originals/7d/74/40/7d7440fb4115bda08c82dd040e461c97.gif"
                class="img-fluid rounded"
                alt="Responsive image"
                width="100%"
                height="400"
              />
            </template>
          </iq-card>
        </b-col>
      </b-row>
    </b-col>
  </b-row>
</template>

<script>
import { getPosts } from '@/api/post'

export default {
  name: 'HomePage',
  components: {
    IqCard: () => import('./IqCard'),
    SocialPost: () => import('./SocialPost')
  },
  data() {
    return {
      loading: false,
      posts: [],
      page: 0,
      has: true
    }
  },
  beforeMount() {
    this.fetchData(0)
  },
  mounted() {
    setTimeout(() => window.addEventListener('scroll', this.onScroll), 1000)
  },
  beforeDestroy() {
    window.removeEventListener('scroll', this.onScroll)
  },
  methods: {
    openLink() {
      window.open('https://www.facebook.com/profile.php?id=100069109730056', '_blank')
    },
    onScroll() {
      if (!this.has) {
        return
      }
      const { documentElement } = document
      const a = documentElement.scrollTop + window.innerHeight
      const b = documentElement.offsetHeight
      if ((a / b) * 100 > 90) {
        const p = this.page + 1
        this.page = p
        this.fetchData(p, true)
      }
    },
    async fetchData(page, plus) {
      this.loading = true
      try {
        const data = await getPosts(page, 4)
        if (data) {
          if (plus) {
            data.forEach((e) => this.posts.push(e))
          } else {
            this.posts = data
          }
          if (data.length < 4) {
            this.has = false
          }
        }
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      } finally {
        this.loading = false
      }
    }
  }
}
</script>
