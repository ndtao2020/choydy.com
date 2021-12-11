<template>
  <div class="container-fluid p-0">
    <div class="row no-gutters">
      <div class="col-sm-12 text-center">
        <div class="iq-error position-relative mt-5" :class="$route.params.code !== '404' ? 'error-500' : ''">
          <h2 class="mb-0">Oops! This Page is Not Found.</h2>
          <p>The requested page dose not exist.</p>
          <button class="btn btn-primary mt-3" @click="$router.go(-1)"><i class="ri-home-4-line"></i>Back to Home</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { socialvue } from '../../config/pluginInit'

export default {
  name: 'ErrorPage',
  data() {
    return {
      image404: require('../../assets/images/error/01.png'),
      image500: require('../../assets/images/error/01.png')
    }
  },
  mounted() {
    socialvue.index()
    let body = document.querySelector('body')
    body.classList.add('iq-bg-primary')
  }
}
</script>

<style lang="scss" scoped>
.iq-error {
  position: relative;
  width: 100%;
  height: 100vh;
  overflow: hidden;
  display: inline-block;
}
.iq-error h1.text-in-box {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  font-size: 8em;
  font-weight: 700;
}
.iq-error-img {
  position: static;
  display: inline-block;
}
.error-500 .iq-error-img {
  width: 100%;
}
</style>
