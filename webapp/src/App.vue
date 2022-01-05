<template>
  <router-view />
</template>

<script>
import { mapActions } from 'vuex'
import '@/assets/scss/index.scss'

export default {
  name: 'App',
  created() {
    this.initDB()
    setInterval(() => this.updateDatabase(), 30000)
  },
  methods: {
    ...mapActions('database', ['initDB', 'updateDatabase'])
  }
}
</script>
