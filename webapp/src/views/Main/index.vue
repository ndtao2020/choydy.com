<template>
  <b-row>
    <b-col sm="12">
      <b-row class="m-0 p-0">
        <b-col lg="8">
          <b-card v-if="!isLoaded">
            <b-skeleton animation="wave" width="85%"></b-skeleton>
            <b-skeleton animation="wave" width="55%"></b-skeleton>
            <b-skeleton animation="wave" width="70%"></b-skeleton>
            <b-skeleton-img />
          </b-card>
          <social-post v-for="(id, index) in posts" v-else :key="index" :post-id="id" />
        </b-col>
        <b-col lg="4" class="main-banner">
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
        </b-col>
      </b-row>
    </b-col>
  </b-row>
</template>

<script>
import SocialPost from './SocialPost'
import seoMeta from '@/seo'
import { getPosts } from '@/api/post'
import { getCatalogById } from '@/api/catalog'

const size = 3

export default {
  name: 'HomePage',
  components: {
    SocialPost
  },
  data() {
    return {
      isLoaded: false,
      loading: false,
      posts: [],
      page: 0,
      has: true,
      catalogId: undefined
    }
  },
  watch: {
    $route({ params }) {
      window.scrollTo({ top: 0, left: 0, behavior: 'smooth' })
      this.resetData()
      // set up title
      this.catalogId = params.id
      // fetch data
      this.onChangeRoute()
    }
  },
  beforeMount() {
    const { params } = this.$route
    this.catalogId = params.id
    this.fetchData(0)
    this.setTitle()
  },
  mounted() {
    window.addEventListener('scroll', this.onScroll)
  },
  beforeDestroy() {
    window.removeEventListener('scroll', this.onScroll)
  },
  methods: {
    openLink(link) {
      window.open(link, '_blank')
    },
    resetData() {
      this.posts = []
      this.page = 0
      this.has = true
      this.isLoaded = false
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
        const data = await getPosts(page, size, this.catalogId)
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
        if (!this.isLoaded) {
          this.isLoaded = true
        }
        this.loading = false
      }
    },
    async setTitle() {
      try {
        if (this.catalogId) {
          const catalog = await getCatalogById(this.catalogId)
          seoMeta({
            title: catalog[0],
            metaTags: [
              {
                name: 'description',
                content: `${catalog[0]} |Trang tin cập nhật những Meme hài hước, vui nhộn.`
              },
              {
                name: 'og:title',
                content: `${catalog[0]} | ChoyDy.Com - Meme hài hước`
              },
              {
                property: 'og:description',
                content: `${catalog[0]} |Trang tin cập nhật những Meme hài hước, vui nhộn.`
              }
            ]
          })
        }
      } catch (error) {
        seoMeta({ title: 'Danh mục' })
        // eslint-disable-next-line no-console
        console.log(error)
      }
    },
    async onChangeRoute() {
      try {
        await this.setTitle()
        await this.fetchData(this.page, true)
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      }
    }
  }
}
</script>
