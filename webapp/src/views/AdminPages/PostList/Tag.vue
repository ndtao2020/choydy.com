<template>
  <div>
    <b-skeleton v-if="loading" width="100%" />
    <b-button v-for="a in arr" v-else :key="a" variant="link">#{{ a }}</b-button>
  </div>
</template>

<script>
import { findAllTagByPostId } from '@/api/post'

export default {
  name: 'SimpleTag',
  props: {
    id: { type: String, default: '' },
    tags: { type: Array }
  },
  data() {
    return {
      loading: false,
      arr: []
    }
  },
  mounted() {
    if (!this.tags) {
      this.loadData()
    } else {
      this.arr = this.tags
    }
  },
  methods: {
    async loadData() {
      this.loading = true
      try {
        const data = await findAllTagByPostId(this.id)
        if (data) {
          this.arr = data
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
