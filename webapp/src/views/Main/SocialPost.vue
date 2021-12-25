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
            <b-link v-if="!loading" class="text-secondary">({{ catalog[0] }})</b-link>
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
      <div v-for="(a, i) in media" v-else :key="i" class="d-flex">
        <img v-if="a[1] === 'image/jpeg' || a[1] === 'image/png' || a[1] === 'image/gif'" class="mx-auto" :src="getURL(a)" />
        <Player v-if="a[1] === 'video/mp4' || a[1] === 'video/webm'" :source="{ src: getURL(a), type: a[1] }" />
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
                      ><img :src="require('@/assets/images/icon/01.png')" class="img-fluid" alt=""
                    /></a>
                    <a class="mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Love" @click="isLiked(!post.is_liked)"
                      ><img :src="require('@/assets/images/icon/02.png')" class="img-fluid" alt=""
                    /></a>
                    <a class="mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Happy" @click="isLiked(!post.is_liked)"
                      ><img :src="require('@/assets/images/icon/03.png')" class="img-fluid" alt=""
                    /></a>
                    <a class="mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="HaHa" @click="isLiked(!post.is_liked)"
                      ><img :src="require('@/assets/images/icon/04.png')" class="img-fluid" alt=""
                    /></a>
                    <a class="mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Think" @click="isLiked(!post.is_liked)"
                      ><img :src="require('@/assets/images/icon/05.png')" class="img-fluid" alt=""
                    /></a>
                    <a class="mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Sade" @click="isLiked(!post.is_liked)"
                      ><img :src="require('@/assets/images/icon/06.png')" class="img-fluid" alt=""
                    /></a>
                    <a class="mr-2" data-toggle="tooltip" data-placement="top" title="" data-original-title="Lovely" @click="isLiked(!post.is_liked)"
                      ><img :src="require('@/assets/images/icon/07.png')" class="img-fluid" alt=""
                    /></a>
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
            <!-- <div class="total-comment-block">
              <div class="dropdown">
                <span class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button">
                  {{ post.comments }} Bình luận
                </span>
              </div>
            </div> -->
          </div>
        </div>
        <div class="share-block d-flex align-items-center feather-icon mr-3">
          <span class="ml-1">{{ post.shares }} Chia sẻ</span>
        </div>
      </div>
      <!-- <hr /> -->
      <!-- <ul class="post-comments p-0 m-0">
        <li v-for="(postComment, postCommentIndex) in post.comments" :key="postComment.id" class="mb-2">
          <div class="d-flex flex-wrap">
            <div class="user-img">
              <b-img :src="postComment.image" alt="userimg" class="avatar-35" rounded="circle" fluid />
            </div>
            <div class="comment-data-block ml-3">
              <h6>{{ postComment.user.name }}</h6>
              <p class="mb-0">{{ postComment.user.msg }}</p>
              <div class="d-flex flex-wrap align-items-center comment-activity">
                <b-link @click="isLikedComment(postCommentIndex, !postComment.is_commentLike)">
                  <span v-if="!postComment.is_commentLike" class="text-primary">like</span>
                  <span v-else class="text-secondary">unlike</span>
                </b-link>
                <b-link>reply</b-link>
                <span>{{ postComment.user.time }}</span>
              </div>
            </div>
          </div>
        </li>
      </ul> -->
      <!-- <b-form class="comment-text d-flex align-items-center mt-3">
        <b-form-input v-model="commentMessage" type="text" class="rounded" placeholder="Lovely!" @keyup.enter="saveComment(commentMessage)" />
        <div class="comment-attagement d-flex">
          <b-link><i class="ri-send-plane-line mr-2" @click="saveComment(commentMessage)"></i></b-link>
        </div>
      </b-form> -->
    </div>
  </iq-card>
</template>

<script>
import moment from 'moment'
import Player from './Player'
import { getCatalogById } from '@/api/catalog'
import { getPostById } from '@/api/post'
import { getUserById } from '@/api/user'
import { findAllTagByPostId } from '@/api/tag'
import { findAllMediaByPostId } from '@/api/media'

export default {
  components: {
    Player,
    IqCard: () => import('./IqCard')
  },
  props: {
    id: String
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
      return moment(value).fromNow()
    },
    async fetchPostById() {
      this.loading = true
      try {
        const data = await getPostById(this.id)
        if (data) {
          this.post = data
          this.user = await getUserById(data.userId)
          this.catalog = await getCatalogById(data.catalogId)
          if (data.tags) {
            this.tags = data.tags
          } else {
            this.tags = await findAllTagByPostId(this.id)
          }
          if (data.media) {
            this.media = data.media
          } else {
            this.media = await findAllMediaByPostId(this.id)
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
      return `/api/public/media?id=${id}&type=${type}`
    },
    isLiked(postLike) {
      // this.post.is_liked = postLike

      if (postLike) {
        // this.post.likes += 1
      } else {
        // this.post.likes -= 1
      }
    },
    // isFollowed(follow) {
    isFollowed() {
      // this.post.is_follow = follow
    },
    // isLikedComment(index, like) {
    isLikedComment() {
      // this.post.comments[index].is_commentLike = like
    },
    saveComment() {
      this.commentMessage = ''
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
