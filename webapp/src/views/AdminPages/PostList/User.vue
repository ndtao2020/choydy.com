<template>
  <div>
    <b-skeleton v-if="loading" width="85%" />
    <div v-else class="d-flex">
      <b-img rounded="circle" fluid :src="avatar" alt="" height="20" width="20" class="mr-2" />
      <div>{{ name }}</div>
    </div>
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
      name: null,
      avatar: null
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
          this.name = data[0]
          this.avatar = data[1]
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
