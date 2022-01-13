<template>
  <div class="mx-auto">
    <div v-if="isLoad">
      <div class="spinner-grow text-primary" role="status" />
      <div class="spinner-grow text-success" role="status" />
      <div class="spinner-grow text-danger" role="status" />
    </div>
    <img v-show="!isLoad" :src="src" height="500" width="500" :alt="alt" @load="isLoad = false" @error="isLoad = true" />
  </div>
</template>

<script>
export default {
  name: 'ImagePost',
  props: {
    alt: String,
    src: String
  },
  data() {
    return {
      isLoad: false
    }
  },
  beforeMount() {
    this.isLoad = true
  },
  beforeDestroy() {
    this.isLoad = false
  }
}
</script>
