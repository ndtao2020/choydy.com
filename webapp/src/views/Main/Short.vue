<template>
  <div class="card mb-3 shadow bg-body rounded" style="max-width: 540px; height: 200px">
    <div class="row g-0">
      <div v-for="(a, i) in media" :key="i" class="col-md-4">
        <img :src="checkTypeImage(a[1]) ? getURL(a) : getThumbnailURL(a)" :alt="post.title" class="img-fluid rounded-start" width="100%" />
      </div>
      <div class="col-md-8">
        <div class="card-body">
          <h5 class="card-title">{{ post.title }}</h5>
          <p class="card-text overflow-hidden">{{ post.content }}</p>
          <div class="d-flex">
            <img fluid :src="user[1]" alt="" height="20" width="20" class="mr-2 rounded-circle" />
            <div>{{ user[0] }}</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { IMAGE_TYPES } from '@/constants'
import { getUserById } from '@/api/user'
import { getPostById, findAllTagByPostId, findAllMediaByPostId, getMediaLink, getThumbnailMediaLink } from '@/api/post'

export default {
  name: 'ShortDetail',
  props: {
    postId: String
  },
  data() {
    return {
      observer: null,
      loading: false,
      likeLoading: false,
      likes: null,
      isLiked: null,
      showCopiedLink: false,
      post: {},
      user: [],
      catalog: [],
      tags: [],
      media: [],
      commentMessage: ''
    }
  },
  mounted() {
    this.fetchPostById()
  },
  methods: {
    checkTypeImage(type) {
      return IMAGE_TYPES.some((x) => x === type)
    },
    getURL(data) {
      const [id, type] = data
      return getMediaLink(id, type)
    },
    getThumbnailURL(data) {
      const [id, type] = data
      return getThumbnailMediaLink(id, type)
    },
    async fetchPostById() {
      this.loading = true
      try {
        const data = await getPostById(this.postId)
        if (!data) return this.$router.push('/')
        // handle
        this.post = data
        try {
          this.user = await getUserById(data.userId)
        } catch (error) {
          // eslint-disable-next-line no-console
          console.log(error)
        }
        if (data.tags) {
          this.tags = data.tags
        } else {
          try {
            this.tags = await findAllTagByPostId(this.postId)
          } catch (error) {
            // eslint-disable-next-line no-console
            console.log(error)
          }
        }
        if (data.media) {
          this.media = data.media
        } else {
          try {
            this.media = await findAllMediaByPostId(this.postId)
          } catch (error) {
            // eslint-disable-next-line no-console
            console.log(error)
          }
        }
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      } finally {
        this.loading = false
      }
    }
  }
}
</script>
