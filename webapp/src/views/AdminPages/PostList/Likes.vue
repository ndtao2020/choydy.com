<template>
  <div>
    <b-skeleton v-if="loading" width="100%" />
    <span v-else>{{ total }}</span>
  </div>
</template>

<script>
import { getAllLikeByPostId } from '@/api/postlike'

export default {
  name: 'SimpleTag',
  props: {
    id: { type: String, default: '' },
    tags: { type: Array }
  },
  data() {
    return {
      loading: false,
      total: 0
    }
  },
  mounted() {
    this.loadData()
  },
  methods: {
    async loadData() {
      this.loading = true
      try {
        const data = await getAllLikeByPostId(this.id)
        if (data) {
          let total = 0
          for (let index = 0; index < data.length; index++) {
            const element = data[index]
            total += element[1]
          }
          this.total = total
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
