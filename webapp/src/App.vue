<template>
  <router-view />
</template>
<script>
import { socialvue } from './config/pluginInit'
import '@/assets/scss/style.scss'
export default {
  name: 'App',
  mounted() {
    socialvue.mainIndex()
  }
}
</script>
