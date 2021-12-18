<template>
  <div>
    <b-skeleton v-if="loading" width="100%" />
    <span v-for="a in arr" v-else :key="a">{{ a }}</span>
  </div>
</template>

<script>
import { findAllMediaByPostId } from '@/api/media'

export default {
  name: 'SimpleTag',
  props: {
    id: { type: String, default: '' },
    media: { type: Array }
  },
  data() {
    return {
      loading: false,
      arr: []
    }
  },
  mounted() {
    if (!this.media) {
      this.loadData()
    } else {
      this.arr = this.media
    }
  },
  methods: {
    async loadData() {
      this.loading = true
      try {
        const data = await findAllMediaByPostId(this.id)
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
