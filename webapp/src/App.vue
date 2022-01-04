<template>
  <router-view />
</template>

<script>
import { mapActions } from 'vuex'
import '@/assets/scss/index.scss'

export default {
  name: 'App',
  async created() {
    await this.initDB()
    setInterval(() => this.updateDatabase(), 20000)
  },
  methods: {
    ...mapActions('database', ['initDB', 'updateDatabase'])
  }
}
</script>
