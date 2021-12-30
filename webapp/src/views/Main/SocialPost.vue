<template>
  <div class="iq-card">
    <div class="user-post-data p-3">
      <div class="media-support">
        <div class="d-flex">
          <div class="media-support-user-img mr-2 pt-2">
            <b-skeleton v-if="loading" type="avatar" />
            <img v-else class="img-fluid rounded-circle" :src="user[1]" alt="" height="35" width="35" />
          </div>
          <div class="media-support-info">
            <div class="mb-0">
              <b-skeleton v-if="loading" animation="wave" width="100%" />
              <a v-else target="_self" href="#">{{ user[0] }}</a>
            </div>
            <p class="mb-0 text-secondary">{{ formatTime(post.created) }}</p>
          </div>
        </div>
        <div class="media-support-title">
          <span v-if="!loading" class="title">{{ post.title }}</span>
          <span v-if="!loading" class="catalog text-secondary">({{ catalog[0] }})</span>
        </div>
      </div>
    </div>
    <div class="user-post">
      <div v-if="loading" class="mx-4 mb-3">
        <b-skeleton animation="wave" width="85%"></b-skeleton>
        <b-skeleton animation="wave" width="55%"></b-skeleton>
      </div>
      <p v-if="!loading && post.content" class="pl-3">
        {{ post.content }}<button v-for="tag in tags" :key="tag" type="button" class="btn btn-link">#{{ tag }}</button>
      </p>
      <div class="mt-1" />
      <b-skeleton-img v-if="loading" height="500px" />
      <div v-for="(a, i) in media" v-else :key="i" class="d-flex post-media">
        <img v-if="a[1] === 'image/jpeg' || a[1] === 'image/png' || a[1] === 'image/gif'" class="mx-auto" :src="getURL(a)" height="500" width="500" />
        <Player v-if="a[1] === 'video/mp4' || a[1] === 'video/webm'" :post-id="postId" :src="getURL(a)" :type="a[1]" />
      </div>
    </div>
    <div class="comment-area py-1 px-3">
      <div class="d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center justify-content-between">
          <div class="like-block position-relative d-flex align-items-center">
            <div class="d-flex align-items-center">
              <div class="like-data">
                <div class="dropdown">
                  <span>
                    <img src="@/assets/images/icon/01.png" class="img-fluid" alt="" height="24" width="24" />
                  </span>
                  <div class="dropdown-menu" style="">
                    <img class="ml-2 mr-2 img-fluid" src="@/assets/images/icon/01.png" alt="" height="24" width="24" />
                    <img class="mr-2 img-fluid" src="@/assets/images/icon/02.png" alt="" height="24" width="24" />
                    <img class="mr-2 img-fluid" src="@/assets/images/icon/03.png" alt="" height="24" width="24" />
                    <img class="mr-2 img-fluid" src="@/assets/images/icon/04.png" alt="" height="24" width="24" />
                    <img class="mr-2 img-fluid" src="@/assets/images/icon/05.png" alt="" height="24" width="24" />
                    <img class="mr-2 img-fluid" src="@/assets/images/icon/06.png" alt="" height="24" width="24" />
                    <img class="mr-2 img-fluid" src="@/assets/images/icon/07.png" alt="" height="24" width="24" />
                  </div>
                </div>
              </div>
              <div class="total-like-block ml-2">
                <div class="dropdown">
                  <span>
                    {{ post.likes }}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="share-block">{{ post.shares }} Chia sẻ</div>
      </div>
    </div>
  </div>
</template>

<script>
import Player from './Player'
import { dateDiff } from '@/moment'
import { getUserById } from '@/api/user'
import { getCatalogById } from '@/api/catalog'
import { getPostById, findAllTagByPostId, findAllMediaByPostId, getMediaLink } from '@/api/post'
import { BSkeleton, BSkeletonImg } from 'bootstrap-vue/src/components/skeleton'

export default {
  components: {
    Player,
    BSkeleton,
    BSkeletonImg
  },
  props: {
    postId: String
  },
  data() {
    return {
      loading: false,
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
    formatTime(value) {
      if (value) {
        return dateDiff(new Date(value))
      }
      return ''
    },
    async fetchPostById() {
      this.loading = true
      try {
        const data = await getPostById(this.postId)
        if (data) {
          this.post = data
          try {
            this.user = await getUserById(data.userId)
          } catch (error) {
            // eslint-disable-next-line no-console
            console.log(error)
          }
          try {
            this.catalog = await getCatalogById(data.catalogId)
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
        }
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
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
