<template>
  <div class="p-0">
    <div class="user-post-data p-3">
      <div class="d-flex flex-wrap">
        <div class="media-support-user-img mr-3">
          <b-img rounded="circle" fluid :src="user[1]" alt="" height="50" width="50" />
        </div>
        <div class="media-support-info mt-2">
          <h5 class="mb-0">
            <b-link class="">{{ user[0] }}</b-link>
          </h5>
          <p class="mb-0 text-secondary">{{ formatTime(new Date().getTime()) }}</p>
        </div>
      </div>
    </div>
    <hr class="m-0" />
    <div class="d-flex user-post">
      <div class="mx-auto">
        <h2>{{ post.title }}</h2>
        <p>
          {{ post.content }}
        </p>
        <b-button v-for="tag in post.tags" :key="tag" variant="link">#{{ tag }}</b-button>
        <div>
          <img v-if="tab === 0 && image" :src="image" />
          <video
            v-if="tab === 1 && video"
            ref="video"
            width="90%"
            :src="video"
            loop
            controls
            autoplay
            @loadedmetadata="onLoadedmetadata"
            @timeupdate="onVideoTimeUpdate"
          />
        </div>
      </div>
    </div>
    <div class="comment-area p-3">
      <div class="d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center justify-content-between">
          <div class="like-block position-relative d-flex align-items-center">
            <div class="d-flex align-items-center">
              <div class="like-data">
                <div class="dropdown">
                  <span class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button">
                    <img :src="require('@/assets/images/icon/normal.png')" class="img-fluid" alt="" />
                  </span>
                  <div class="dropdown-menu" style="">
                    <a
                      class="ml-2 mr-2"
                      data-toggle="tooltip"
                      data-placement="top"
                      title=""
                      data-original-title="Like"
                      @click="isLiked(!post.is_liked)"
                    >
                      <img :src="require('@/assets/images/icon/normal.png')" class="img-fluid" alt="" />
                    </a>
                  </div>
                </div>
              </div>
              <div class="total-like-block ml-2 mr-3">
                <div class="dropdown">
                  <span class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button"> 1.1k Likes </span>
                </div>
              </div>
            </div>
            <div class="total-comment-block">
              <div class="dropdown">
                <span class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button"> 2 Bình luận </span>
              </div>
            </div>
          </div>
        </div>
        <div class="share-block d-flex align-items-center feather-icon mr-3">
          <a><i class="ri-share-line"></i> <span class="ml-1">99 Share</span></a>
        </div>
      </div>
      <hr />
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { getUserById } from '@/api/user'
import { dateDiff } from '@/moment'

export default {
  name: 'SocialPost',
  props: {
    post: Object,
    tab: [Number],
    image: [Object, String],
    video: [Object, String]
  },
  data() {
    return {
      loading: false,
      user: []
    }
  },
  computed: {
    ...mapGetters('auth', ['logged', 'id'])
  },
  mounted() {
    if (this.logged) {
      this.fetchUserData()
    }
  },
  methods: {
    async fetchUserData() {
      this.loading = true
      try {
        this.user = await getUserById(this.id)
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      } finally {
        this.loading = false
      }
    },
    formatTime(value) {
      if (value) {
        return dateDiff(value)
      }
      return ''
    },
    onLoadedmetadata() {
      const { video } = this.$refs
      if (!video) {
        return
      }
      this.$emit('loadmeta', {
        width: video.videoWidth / 3,
        height: video.videoHeight / 3
      })
    },
    onVideoTimeUpdate() {
      const { video } = this.$refs
      if (!video) {
        return
      }
      // return
      this.$emit('update', video)
    }
  }
}
</script>

<style>
.dropdown-item {
  color: #212529 !important;
}
.dropdown-menu .dropdown-item:focus,
.dropdown-menu .dropdown-item:hover {
  background: transparent;
  color: var(--gray-dark) !important;
}
</style>
