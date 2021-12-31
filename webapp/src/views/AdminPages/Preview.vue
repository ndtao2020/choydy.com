<template>
  <iq-card body-class="p-0">
    <template #body>
      <div class="user-post-data p-3">
        <div class="d-flex flex-wrap">
          <div class="media-support-user-img mr-3">
            <b-img rounded="circle" fluid src="https://giay.store/assets/images/default-avatar.png" alt="" height="50" width="50" />
          </div>
          <div class="media-support-info mt-2">
            <h5 class="mb-0">
              <b-link class="">Người dùng</b-link>
            </h5>
            <p class="mb-0 text-secondary">{{ new Date() }}</p>
          </div>
        </div>
      </div>
    </template>
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
            controls
            autoplay
            @loadedmetadata="onLoadedmetadata"
            @timeupdate="onVideoTimeUpdate"
          />
        </div>
      </div>
    </div>
    <canvas ref="canvas" style="display: none" />
    <div class="comment-area p-3">
      <div class="d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center justify-content-between">
          <div class="like-block position-relative d-flex align-items-center">
            <div class="d-flex align-items-center">
              <div class="like-data">
                <div class="dropdown">
                  <span class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button">
                    <img :src="require('@/assets/images/icon/01.png')" class="img-fluid" alt="" />
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
                      <img :src="require('@/assets/images/icon/01.png')" class="img-fluid" alt="" />
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
  </iq-card>
</template>

<script>
export default {
  name: 'SocialPost',
  components: {
    IqCard: () => import('@/components/socialvue/cards/iq-card')
  },
  props: {
    post: Object,
    tab: [Number],
    image: [Object, String],
    video: [Object, String]
  },
  methods: {
    onLoadedmetadata() {
      const { video, canvas } = this.$refs
      if (!video || !canvas) {
        return
      }
      // Set canvas dimensions same as video dimensions
      canvas.width = video.videoWidth
      canvas.height = video.videoHeight
    },
    onVideoTimeUpdate() {
      const { video, canvas } = this.$refs
      if (!video || !canvas) {
        return
      }
      // Placing the current frame image of the video in the canvas
      canvas.getContext('2d').drawImage(video, 0, 0, video.videoWidth, video.videoHeight)
      // file
      var blobBin = atob(canvas.toDataURL().split(',')[1])
      var array = []
      for (var i = 0; i < blobBin.length; i++) {
        array.push(blobBin.charCodeAt(i))
      }
      // return
      this.$emit('update', new Blob([new Uint8Array(array)], { type: 'image/png' }))
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
