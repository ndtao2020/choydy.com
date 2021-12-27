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
import IqCard from './IqCard'
import SocialPost from './SocialPost'
import { getPosts } from '@/api/post'

const size = 3

export default {
  name: 'HomePage',
  components: {
    IqCard,
    SocialPost
  },
  data() {
    return {
      loading: false,
      posts: [],
      page: 0,
      has: true,
      calatalogId: undefined
    }
  },
  watch: {
    $route({ params }) {
      this.resetData()
      this.calatalogId = params.id
      this.fetchData(this.page, true)
    }
  },
  beforeMount() {
    const { params } = this.$route
    this.calatalogId = params.id
    this.fetchData(0)
    // scroll to the top of the document
    document.body.scrollTop = 0 // For Safari
    document.documentElement.scrollTop = 0 // For Chrome, Firefox, IE and Opera
  },
  mounted() {
    window.addEventListener('scroll', this.onScroll)
  },
  beforeDestroy() {
    window.removeEventListener('scroll', this.onScroll)
  },
  methods: {
    openLink() {
      window.open('https://www.facebook.com/profile.php?id=100069109730056', '_blank')
    },
    resetData() {
      this.posts = []
      this.page = 0
      this.has = true
    },
    onScroll() {
      if (this.loading || !this.has) {
        return
      }
      const { documentElement } = document
      const a = documentElement.scrollTop + window.innerHeight
      if ((a / documentElement.offsetHeight) * 100 > 85) {
        this.page = this.page + 1
        this.fetchData(this.page, true)
      }
    },
    async fetchData(page, plus) {
      this.loading = true
      try {
        const data = await getPosts(page, size, this.calatalogId)
        if (data) {
          if (plus) {
            data.forEach((e) => this.posts.push(e))
          } else {
            this.posts = data
          }
          if (data.length < size) {
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
