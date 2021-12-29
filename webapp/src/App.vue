<template>
  <router-view />
</template>

<script>
import { mapActions } from 'vuex'
import '@/assets/scss/index.scss'

export default {
  name: 'App',
  mounted() {
    this.initDB()
  },
  methods: {
    ...mapActions('database', ['initDB'])
  }
}
</script>
