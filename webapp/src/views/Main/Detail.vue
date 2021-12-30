<template>
  <social-post :post-id="postId" />
</template>

<script>
import SocialPost from './SocialPost'
// import seoMeta from '@/seo'

export default {
  name: 'HomePage',
  components: {
    SocialPost
  },
  data() {
    return {
      loading: false,
      postId: null
    }
  },
  mounted() {
    this.postId = this.$route.params.id
  }
}
</script>
