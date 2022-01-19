<template>
  <div>
    <social-post :post-id="$route.params.id" />
    <ins
      class="adsbygoogle"
      style="display: block; text-align: center"
      data-ad-layout="in-article"
      data-ad-format="fluid"
      data-ad-client="ca-pub-5727937131697376"
      data-ad-slot="7602428355"
    ></ins>
    <hr />
    <h6>Gợi ý dành cho bạn</h6>
    <hr />
    <div class="row">
      <div v-for="recommend in recommends" :key="recommend" class="col-md-6">
        <short :post-id="recommend" />
      </div>
    </div>
  </div>
</template>

<script>
import SocialPost from './SocialPost'
import { getRecommends } from '@/api/post'

export default {
  name: 'HomePage',
  components: {
    SocialPost,
    Short: () => import('./Short')
  },
  data() {
    return {
      loading: false,
      recommends: []
    }
  },
  watch: {
    $route: {
      handler: function ({ params }) {
        this.fetchData(params.id)
      },
      immediate: true,
      deep: true
    }
  },
  mounted() {
    window.adsbygoogle.push({})
  },
  methods: {
    async fetchData(id) {
      this.loading = true
      try {
        const data = await getRecommends(id)
        if (data) {
          this.recommends = data
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
