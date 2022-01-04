<template>
  <div class="iq-card">
    <div class="user-post-data p-3">
      <div class="media-support">
        <div class="d-flex">
          <div class="media-support-user-img mr-2 pt-2">
            <b-skeleton v-if="loading" type="avatar" />
            <img v-else class="rounded-circle" :src="user[1]" alt="" height="35" width="35" />
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
    <div class="py-1 px-3">
      <div class="d-flex">
        <div class="d-flex">
          <div class="like-data">
            <div class="dropdown">
              <span v-if="isLiked">
                <img v-if="isLiked[0] === 'normal'" src="@/assets/images/icon/01.png" alt="" height="24" width="24" />
                <img v-if="isLiked[0] === 'heart'" src="@/assets/images/icon/02.png" alt="" height="24" width="24" />
                <img v-if="isLiked[0] === 'haha'" src="@/assets/images/icon/03.png" alt="" height="24" width="24" />
                <img v-if="isLiked[0] === 'angry'" src="@/assets/images/icon/04.png" alt="" height="24" width="24" />
                <img v-if="isLiked[0] === 'ask'" src="@/assets/images/icon/05.png" alt="" height="24" width="24" />
                <img v-if="isLiked[0] === 'sad'" src="@/assets/images/icon/06.png" alt="" height="24" width="24" />
                <img v-if="isLiked[0] === 'love'" src="@/assets/images/icon/07.png" alt="" height="24" width="24" />
              </span>
              <span v-else>
                <img src="@/assets/images/icon/01.png" alt="" height="24" width="24" />
              </span>
              <div class="dropdown-menu" style="">
                <img
                  :class="['ml-3 mr-2', { 'liked-icon': isLiked && isLiked[0] === 'normal' }]"
                  src="@/assets/images/icon/01.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('normal')"
                />
                <img
                  :class="['mr-2', { 'liked-icon': isLiked && isLiked[0] === 'heart' }]"
                  src="@/assets/images/icon/02.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('heart')"
                />
                <img
                  :class="['mr-2', { 'liked-icon': isLiked && isLiked[0] === 'haha' }]"
                  src="@/assets/images/icon/03.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('haha')"
                />
                <img
                  :class="['mr-2', { 'liked-icon': isLiked && isLiked[0] === 'angry' }]"
                  src="@/assets/images/icon/04.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('angry')"
                />
                <img
                  :class="['mr-2', { 'liked-icon': isLiked && isLiked[0] === 'ask' }]"
                  src="@/assets/images/icon/05.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('ask')"
                />
                <img
                  :class="['mr-2', { 'liked-icon': isLiked && isLiked[0] === 'sad' }]"
                  src="@/assets/images/icon/06.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('sad')"
                />
                <img
                  :class="{ 'liked-icon': isLiked && isLiked[0] === 'love' }"
                  src="@/assets/images/icon/07.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('love')"
                />
              </div>
            </div>
          </div>
          <div class="total-like-block ml-2">
            <div class="dropdown">
              <span v-if="isLiked" class="text-success">Đã thích</span>
              <span v-else>{{ post.likes }}</span>
            </div>
          </div>
        </div>
        <div class="ml-auto share-block d-flex">
          <div class="mr-2 my-auto">{{ post.shares }}</div>
          <div class="dropdown">
            <span>
              <img src="@/assets/icons/share.svg" alt="" height="24" width="24" />
            </span>
            <div class="dropdown-menu" style="">
              <div class="px-3 py-2" @click="shareFacebook">
                <img class="mr-3" src="@/assets/icons/socials/facebook.png" alt="" height="30" width="30" />
                <span>Chia sẻ Facebook</span>
              </div>
              <div class="px-3 py-2" @click="shareTwitter">
                <img class="mr-3" src="@/assets/icons/socials/twitter.png" alt="" height="30" width="30" />
                <span>Chia sẻ Twitter</span>
              </div>
              <div class="px-3 py-2" @click="shareZalo">
                <img class="mr-3" src="@/assets/icons/socials/zalo.png" alt="" height="30" width="30" />
                <span>Chia sẻ Zalo</span>
              </div>
              <div id="popover-button-sync" class="px-3 py-2" @click="copyLink">
                <img class="mr-3" src="@/assets/icons/socials/link.png" alt="" height="30" width="30" />
                <span class="mr-3">Sao chép link</span>
                <img v-if="showCopiedLink" src="@/assets/icons/success.svg" alt="" height="24" width="24" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Player from './Player'
import { mapGetters } from 'vuex'
import { dateDiff } from '@/moment'
import { getUserById } from '@/api/user'
import { getCatalogById } from '@/api/catalog'
import { checkLiked } from '@/api/auth/postlike'
import { getPostById, findAllTagByPostId, findAllMediaByPostId, getMediaLink, updateShare, createLike, updateLike, removeLike } from '@/api/post'
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
      likeLoading: false,
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
  computed: {
    ...mapGetters('auth', ['logged'])
  },
  mounted() {
    this.fetchPostById()
    if (this.logged) {
      this.authLiked()
    }
  },
  methods: {
    formatTime(value) {
      if (value) {
        return dateDiff(value)
      }
      return ''
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
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      } finally {
        this.loading = false
      }
    },
    async authLiked() {
      this.likeLoading = true
      try {
        const data = await checkLiked(this.postId)
        if (data) {
          this.isLiked = data[0]
        }
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      } finally {
        this.likeLoading = false
      }
    },
    getURL(data) {
      const [id, type] = data
      return getMediaLink(id, type)
    },
    // like
    async toggleLike(type) {
      if (!this.logged) {
        return this.$router.push('/')
      }
      try {
        if (this.isLiked) {
          if (this.isLiked[0] === type) {
            // remove like
            if (this.post.likes) {
              this.post.likes -= 1
            }
            this.isLiked = null
            await removeLike(this.postId)
          } else {
            // update like
            this.isLiked = [type, new Date().getTime()]
            await updateLike(this.postId, type)
          }
        } else {
          // add like
          this.post.likes += 1
          this.isLiked = [type, new Date().getTime()]
          await createLike(this.postId, type)
        }
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      }
    },
    // share
    fetchShare() {
      try {
        this.post.shares += 1
        setTimeout(() => updateShare(this.postId), 1000)
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      }
    },
    getShareURL() {
      return `${process.env.VUE_APP_PROXY}/post/${this.postId}`
    },
    shareFacebook() {
      const { title, content } = this.post
      window.open(
        `https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(this.getShareURL())}&title=${encodeURIComponent(
          title
        )}&description=${encodeURIComponent(content)}&hashtag=${encodeURIComponent(this.tags.join(','))}`,
        'Chia sẻ Facebook',
        'popup'
      )
      this.fetchShare()
    },
    shareTwitter() {
      const { title } = this.post
      window.open(
        `https://twitter.com/intent/tweet?url=${encodeURIComponent(this.getShareURL())}&via=@ndtao2020&text=${encodeURIComponent(
          title
        )}&hashtags=${encodeURIComponent(this.tags.join(','))}`,
        'Chia sẻ Twitter',
        'popup'
      )
      this.fetchShare()
    },
    shareZalo() {
      const data = { url: this.getShareURL() }
      window.open(`https://sp.zalo.me/share?d=${Buffer.from(JSON.stringify(data)).toString('base64')}`, 'Chia sẻ Zalo', 'popup')
      this.fetchShare()
    },
    copyLink() {
      this.showCopiedLink = true
      navigator.clipboard.writeText(this.getShareURL())
      setTimeout(() => {
        this.showCopiedLink = false
      }, 2000)
    }
  }
}
</script>
