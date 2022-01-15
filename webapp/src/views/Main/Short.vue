<template>
  <div class="card mb-3 shadow bg-body rounded" @click="openURL">
    <div class="card-body g-0 d-flex">
      <div v-for="(a, i) in media" :key="i" class="preview d-flex align-items-center">
        <img
          :src="checkTypeImage(a[1]) ? getURL(a) : getThumbnailURL(a)"
          :alt="post.title"
          class="img-fluid rounded-start"
          width="100%"
          loading="lazy"
        />
      </div>
      <div class="content m-2">
        <div class="card-title">{{ post.title }}</div>
        <p class="card-text">{{ post.content }}</p>
        <div class="d-flex">
          <img fluid :src="user[1]" alt="" height="20" width="20" class="mr-2 rounded-circle" />
          <div>{{ user[0] }}</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { IMAGE_TYPES } from '@/constants'
import { getUserById } from '@/api/user'
import { getPostById, findAllMediaByPostId, getMediaLink, getThumbnailMediaLink } from '@/api/post'

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
    openURL() {
      window.location.replace(`/post/${this.postId}`)
      return
    },
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

<style lang="scss" scoped>
.card {
  cursor: pointer;
  height: 200px;
  position: relative;
  display: flex;
  flex-direction: column;
  min-width: 0;
  word-wrap: break-word;
  background-color: #fff;
  background-clip: border-box;
  border: 1px solid rgba(0, 0, 0, 0.125);
  .card-body {
    height: inherit;
  }
  .preview {
    height: inherit;
    width: 30%;
    background-color: #000000;
    .img-fluid {
      max-height: 198px;
    }
  }
  .content {
    width: 70%;
    .card-title,
    .card-text {
      display: -webkit-box;
      -webkit-box-orient: vertical;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .card-title {
      font-size: 17px;
      font-weight: bold;
      -webkit-line-clamp: 2;
    }
    .card-text {
      font-size: 14px;
      -webkit-line-clamp: 3;
    }
  }
}
</style>
