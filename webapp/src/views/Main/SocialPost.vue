<template>
  <iq-card body-class="p-0">
    <template #body>
      <div class="user-post-data p-3">
        <div class="d-flex flex-wrap">
          <div class="media-support-user-img mr-3">
            <b-skeleton v-if="loading" type="avatar" />
            <b-img v-else rounded="circle" fluid :src="user.avatar" alt="" />
          </div>
          <div class="media-support-info">
            <h5 class="mb-0">
              <b-skeleton v-if="loading" animation="wave" width="100%" />
              <b-link v-else class="">{{ user.name }}</b-link>
            </h5>
            <p class="mb-0 text-secondary">{{ formatTime(post.created) }}</p>
          </div>
          <div class="iq-card-header-toolbar align-items-center">
            <h4 v-if="!loading" class="pl-4">{{ post.title }}</h4>
            <b-link v-if="!loading" class="float-right text-secondary">({{ catalog[0] }})</b-link>
          </div>
        </div>
      </div>
    </template>
    <div class="user-post">
      <b-card v-if="loading" class="mx-4 mb-3">
        <b-skeleton animation="wave" width="85%"></b-skeleton>
        <b-skeleton animation="wave" width="55%"></b-skeleton>
      </b-card>
      <p v-if="!loading && post.content" class="pl-4">
        {{ post.content }}<b-button v-for="tag in tags" :key="tag" variant="link">#{{ tag }}</b-button>
      </p>
      <div class="mt-1" />
      <b-skeleton-img v-if="loading" height="500px" />
      <div v-for="(a, i) in media" v-else :key="i" class="d-flex post-media">
        <img v-if="a[1] === 'image/jpeg' || a[1] === 'image/png' || a[1] === 'image/gif'" class="mx-auto" :src="getURL(a)" />
        <Player v-if="a[1] === 'video/mp4' || a[1] === 'video/webm'" :post-id="postId" :src="getURL(a)" :type="a[1]" />
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
                    <img src="@/assets/images/icon/01.png" class="img-fluid" alt="" />
                  </span>
                  <div class="dropdown-menu" style="">
                    <img class="ml-2 mr-2 img-fluid" src="@/assets/images/icon/01.png" alt="" />
                    <img class="mr-2 img-fluid" src="@/assets/images/icon/02.png" alt="" />
                    <img class="mr-2 img-fluid" src="@/assets/images/icon/03.png" alt="" />
                    <img class="mr-2 img-fluid" src="@/assets/images/icon/04.png" alt="" />
                    <img class="mr-2 img-fluid" src="@/assets/images/icon/05.png" alt="" />
                    <img class="mr-2 img-fluid" src="@/assets/images/icon/06.png" alt="" />
                    <img class="mr-2 img-fluid" src="@/assets/images/icon/07.png" alt="" />
                  </div>
                </div>
              </div>
              <div class="total-like-block ml-2 mr-3">
                <div class="dropdown">
                  <span class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button">
                    {{ post.likes }}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="share-block d-flex align-items-center feather-icon mr-3">
          <span class="ml-1">{{ post.shares }} Chia sẻ</span>
        </div>
      </div>
    </div>
  </iq-card>
</template>

<script>
import IqCard from './IqCard'
import moment from 'moment'
import Player from './Player'
import { getCatalogById } from '@/api/catalog'
import { getPostById } from '@/api/post'
import { getUserById } from '@/api/user'
import { findAllTagByPostId } from '@/api/tag'
import { getMediaLink, findAllMediaByPostId } from '@/api/media'

export default {
  components: {
    Player,
    IqCard
  },
  props: {
    postId: String
  },
  data() {
    return {
      loading: false,
      user: {},
      catalog: [],
      post: {},
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
      return moment(value).locale('vi').fromNow()
    },
    async fetchPostById() {
      this.loading = true
      try {
        const data = await getPostById(this.postId)
        if (data) {
          this.post = data
          this.user = await getUserById(data.userId)
          this.catalog = await getCatalogById(data.catalogId)
          if (data.tags) {
            this.tags = data.tags
          } else {
            this.tags = await findAllTagByPostId(this.postId)
          }
          if (data.media) {
            this.media = data.media
          } else {
            this.media = await findAllMediaByPostId(this.postId)
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
