<template>
  <social-post :post-id="$route.params.id" />
</template>

<script>
import SocialPost from './SocialPost'
// import seoMeta from '@/seo'

export default {
  name: 'HomePage',
  components: {
    SocialPost
  }
}
</script>
