<template>
  <div />
</template>

<script>
export default {
  name: 'HomePage',
  computed: {
    token() {
      return this.$route.params.username
    }
  },
  mounted() {
    this.$router.push('/')
  }
}
</script>
