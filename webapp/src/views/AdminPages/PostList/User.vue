<template>
  <div>
    <b-skeleton v-if="loading" width="85%" />
    <span v-else>{{ name }}</span>
  </div>
</template>

<script>
import { getUserById } from '@/api/user'

export default {
  name: 'SimpleUser',
  props: {
    id: { type: String, default: '' }
  },
  data() {
    return {
      loading: false,
      avatar: null,
      name: null
    }
  },
  mounted() {
    this.loadData()
  },
  methods: {
    async loadData() {
      this.loading = true
      try {
        const data = await getUserById(this.id)
        if (data) {
          this.avatar = data.avatar
          this.name = data.name
        }
      } catch (e) {
        // eslint-disable-next-line no-console
        console.log(e)
      } finally {
        this.loading = false
      }
    }
  }
}
</script>
