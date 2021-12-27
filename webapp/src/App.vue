<template>
  <router-view />
</template>

<script>
import 'nprogress/nprogress.css'
import { mapActions } from 'vuex'

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
