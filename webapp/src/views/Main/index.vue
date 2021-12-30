<template>
  <div>
    <div v-if="!isLoaded">
      <b-skeleton animation="wave" width="85%"></b-skeleton>
      <b-skeleton animation="wave" width="55%"></b-skeleton>
      <b-skeleton animation="wave" width="70%"></b-skeleton>
      <b-skeleton-img />
    </div>
    <social-post v-for="(id, index) in posts" v-else :key="index" :post-id="id" />
  </div>
</template>

<script>
import SocialPost from './SocialPost'
import seoMeta from '@/seo'
import { getPosts } from '@/api/post'
import { getCatalogById } from '@/api/catalog'
import { BSkeleton, BSkeletonImg } from 'bootstrap-vue/src/components/skeleton'

const size = 3

export default {
  name: 'HomePage',
  components: {
    SocialPost,
    BSkeleton,
    BSkeletonImg
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
        // eslint-disable-next-line no-console
        console.log(error)
      }
    }
  }
}
</script>
