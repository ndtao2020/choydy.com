<template>
  <iq-card body-class="p-0">
    <template #body>
      <div class="user-post-data p-3">
        <div class="d-flex flex-wrap">
          <div class="media-support-user-img mr-3">
            <b-img rounded="circle" fluid :src="user.avatar" alt="" />
          </div>
          <div class="media-support-info mt-2">
            <h5 class="mb-0">
              <b-link class="">{{ user.name }}</b-link>
            </h5>
            <p class="mb-0 text-secondary">{{ formatTime(post.created) }}</p>
          </div>
          <div class="iq-card-header-toolbar d-flex align-items-center">
            <b-dropdown id="dropdownMenuButton40" right variant="none" menu-class="p-0">
              <template #button-content>
                <b-link class="text-secondary">Basss</b-link>
              </template>
            </b-dropdown>
          </div>
        </div>
      </div>
    </template>
    <hr class="m-0" />
    <div class="user-post">
      <p v-if="post.content" class="p-2">{{ post.content }}</p>
      <div id="photo-grid">
        <img v-for="(image, index) in post.images" :key="index" :src="image" />
      </div>
    </div>
    <!-- <div class="comment-area p-3">
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
                    {{ post.likes }} Likes
                  </span>
                  <div class="dropdown-menu">
                    <a class="dropdown-item">Max Emum</a>
                    <a class="dropdown-item">Bill Yerds</a>
                    <a class="dropdown-item">Hap E. Birthday</a>
                    <a class="dropdown-item">Tara Misu</a>
                    <a class="dropdown-item">Midge Itz</a>
                    <a class="dropdown-item">Sal Vidge</a>
                    <a class="dropdown-item">Other</a>
                  </div>
                </div>
              </div>
            </div>
            <div class="total-comment-block">
              <div class="dropdown">
                <span class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button">
                  {{ post.comments.length }} Comment
                </span>
                <div class="dropdown-menu">
                  <a class="dropdown-item">Max Emum</a>
                  <a class="dropdown-item">Bill Yerds</a>
                  <a class="dropdown-item">Hap E. Birthday</a>
                  <a class="dropdown-item">Tara Misu</a>
                  <a class="dropdown-item">Midge Itz</a>
                  <a class="dropdown-item">Sal Vidge</a>
                  <a class="dropdown-item">Other</a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="share-block d-flex align-items-center feather-icon mr-3">
          <a><i class="ri-share-line"></i> <span class="ml-1">99 Share</span></a>
        </div>
      </div>
      <hr />
      <ul class="post-comments p-0 m-0">
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
      </ul>
      <b-form class="comment-text d-flex align-items-center mt-3">
        <b-form-input v-model="commentMessage" type="text" class="rounded" placeholder="Lovely!" @keyup.enter="saveComment(commentMessage)" />
        <div class="comment-attagement d-flex">
          <b-link><i class="ri-send-plane-line mr-2" @click="saveComment(commentMessage)"></i></b-link>
        </div>
      </b-form>
    </div> -->
  </iq-card>
</template>

<script>
import moment from 'moment'
// import { getCatalogs } from '@/api/catalog'
import { getPostById } from '@/api/post'
import { getUserById } from '@/api/user'

export default {
  components: {
    IqCard: () => import('./IqCard')
  },
  props: {
    id: String
  },
  data() {
    return {
      loading: false,
      user: {},
      post: {},
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
        }
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      } finally {
        this.loading = false
      }
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
