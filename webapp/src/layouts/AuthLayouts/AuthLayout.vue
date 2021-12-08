<template>
  <section class="sign-in-page">
    <div id="container-inside">
      <div id="circle-small"></div>
      <div id="circle-medium"></div>
      <div id="circle-large"></div>
      <div id="circle-xlarge"></div>
      <div id="circle-xxlarge"></div>
    </div>
    <b-container class="container p-0">
      <div class="row no-gutters">
        <div class="col-md-6 text-center pt-5">
          <div class="sign-in-detail text-white">
            <a class="sign-in-logo mb-5" href="#"><img src="@/assets/images/logo.png" class="img-fluid" alt="logo" /></a>
          </div>
        </div>
        <div class="col-sm-6 bg-white pt-5">
          <div class="sign-in-from">
            <router-view></router-view>
          </div>
        </div>
      </div>
    </b-container>
  </section>
</template>

<script>
export default {
  name: 'AuthLayout1',
  data() {
    return {
      slickOptions: {
        slidesToShow: 1,
        arrows: false
      }
    }
  }
}
</script>
