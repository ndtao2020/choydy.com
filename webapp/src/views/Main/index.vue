<template>
  <div>
    <div v-if="!isLoaded">
      <b-skeleton animation="wave" width="85%"></b-skeleton>
      <b-skeleton animation="wave" width="55%"></b-skeleton>
      <b-skeleton animation="wave" width="70%"></b-skeleton>
      <b-skeleton-img height="500px" />
    </div>
    <template v-for="(data, index) in posts" v-else>
      <Adsense v-if="data[0]" :key="index" />
      <social-post v-else :key="index" :post-id="data[1]" />
    </template>
  </div>
</template>

<script>
import seoMeta from '@/seo'
import Adsense from './Adsense'
import SocialPost from './SocialPost'
import { getPosts } from '@/api/post'
import { getCatalogById } from '@/api/catalog'
import { BSkeleton, BSkeletonImg } from 'bootstrap-vue/src/components/skeleton'

export default {
  name: 'HomePage',
  components: {
    Adsense,
    SocialPost,
    BSkeleton,
    BSkeletonImg
  },
  data() {
    return {
      isLoaded: false,
      loading: false,
      size: parseInt(process.env.VUE_APP_MAX_SIZE_FETCH) || 3,
      posts: [],
      page: 0,
      has: true,
      catalogId: undefined
    }
  },
  watch: {
    $route: {
      handler: function ({ params }) {
        this.resetData()
        // set up title
        try {
          this.catalogId = parseInt(params.id)
        } catch (error) {
          window.location.replace('/')
          return
        }
        // fetch data
        this.onChangeRoute()
      },
      immediate: true,
      deep: true
    }
  },
  mounted() {
    window.addEventListener('scroll', this.onScroll)
  },
  beforeDestroy() {
    window.removeEventListener('scroll', this.onScroll)
  },
  methods: {
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
        const data = await getPosts(page, this.catalogId)
        if (data) {
          if (plus) {
            data.forEach((e) => this.posts.push([false, e]))
            this.posts.push([true])
          } else {
            this.posts = data
          }
          if (data.length < this.size) {
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
            description: `${catalog[0]} | Trang tin cập nhật những Meme hài hước, vui nhộn.`
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
        window.location.replace('/')
      }
    }
  }
}
</script>
