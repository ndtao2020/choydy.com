<template>
  <!-- loader Start -->
  <div id="loading" :style="style">
    <div id="loading-center"></div>
  </div>
  <!-- loader END -->
</template>
<script>
import lightLogo from '@/assets/images/logo.png'
export default {
  name: 'LoaderVue',
  props: {
    dark: { type: Boolean, default: false }
  },
  data() {
    return {
      logo: lightLogo
    }
  },
  mounted() {
    this.style = `background: #fff url(${this.logo}) no-repeat scroll center center;`
  }
}
</script>
