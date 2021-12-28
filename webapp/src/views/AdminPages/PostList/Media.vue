<template>
  <div>
    <b-skeleton v-if="loading" width="100%" />
    <div v-for="(a, i) in arr" v-else :key="i">
      <img v-if="a[1] === 'image/jpeg' || a[1] === 'image/png' || a[1] === 'image/gif'" :src="getURL(a)" />
      <video v-if="a[1] === 'video/mp4' || a[1] === 'video/webm'" width="90%" :src="getURL(a)" controls autoplay />
    </div>
  </div>
</template>

<script>
import { getMediaLink, findAllMediaByPostId } from '@/api/post'

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
    },
    getURL(data) {
      const [id, type] = data
      return getMediaLink(id, type)
    }
  }
}
</script>
