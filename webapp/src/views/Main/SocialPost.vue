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
    <div ref="post" class="user-post">
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
        <Ima v-if="checkTypeImage(a[1])" :src="getURL(a)" :alt="post.title" />
        <Player
          v-if="checkTypeVideo(a[1])"
          ref="player"
          :post-id="postId"
          :src="getURL(a)"
          :poster="getThumbnailURL(a)"
          :type="a[1]"
          @played="handlePlayed"
        />
      </div>
    </div>
    <div class="py-1 px-3">
      <div class="d-flex">
        <div class="d-flex">
          <div class="like-data">
            <div class="dropdown">
              <span v-if="displayAllLike && displayAllLike.length" @click="toggleLike('normal')">
                <img
                  v-for="like in displayAllLike"
                  :key="like[0]"
                  :src="require(`@/assets/images/icon/${like[0]}.png`)"
                  :class="{ 'liked-i': isLiked === like[0] }"
                  alt=""
                  height="20"
                  width="20"
                />
              </span>
              <span v-else @click="toggleLike('normal')">
                <img src="@/assets/images/icon/normal.png" alt="" height="24" width="24" />
              </span>
              <div class="dropdown-menu">
                <img
                  :class="['ml-3 mr-2', { 'liked-icon': isLiked === 'normal' }]"
                  src="@/assets/images/icon/normal.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('normal')"
                />
                <img
                  :class="['mr-2', { 'liked-icon': isLiked === 'heart' }]"
                  src="@/assets/images/icon/heart.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('heart')"
                />
                <img
                  :class="['mr-2', { 'liked-icon': isLiked === 'haha' }]"
                  src="@/assets/images/icon/haha.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('haha')"
                />
                <img
                  :class="['mr-2', { 'liked-icon': isLiked === 'angry' }]"
                  src="@/assets/images/icon/angry.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('angry')"
                />
                <img
                  :class="['mr-2', { 'liked-icon': isLiked === 'ask' }]"
                  src="@/assets/images/icon/ask.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('ask')"
                />
                <img
                  :class="['mr-2', { 'liked-icon': isLiked === 'sad' }]"
                  src="@/assets/images/icon/sad.png"
                  alt=""
                  height="24"
                  width="24"
                  @click="toggleLike('sad')"
                />
                <img
                  :class="{ 'liked-icon': isLiked === 'love' }"
                  src="@/assets/images/icon/love.png"
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
              <span class="mr-2">{{ getTotalLike }}</span>
              <!-- <span v-if="isLiked">{{ isLiked }}</span> -->
            </div>
          </div>
        </div>
        <div class="ml-auto share-block d-flex">
          <div class="mr-2 my-auto">{{ getTotalShare }}</div>
          <div class="dropdown">
            <span>
              <img src="@/assets/icons/share.svg" alt="" height="20" width="20" />
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
import Ima from './Image'
import Player from './Player'
import { mapGetters } from 'vuex'
import { dateDiff } from '@/moment'
import { getUserById } from '@/api/user'
import { abbreviateNumber } from '@/utils'
import { getCatalogById } from '@/api/catalog'
import { IMAGE_TYPES, VIDEO_TYPES } from '@/constants'
import { getAllLikeByPostId, checkLiked, createLike, updateLike, removeLike } from '@/api/postlike'
import { getPostById, findAllTagByPostId, findAllMediaByPostId, getMediaLink, getThumbnailMediaLink, updateView, updateShare } from '@/api/post'
import { BSkeleton, BSkeletonImg } from 'bootstrap-vue/src/components/skeleton'

export default {
  components: {
    Ima,
    Player,
    BSkeleton,
    BSkeletonImg
  },
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
  computed: {
    ...mapGetters('auth', ['logged']),
    displayAllLike() {
      if (this.likes && this.likes.length) {
        const list = []
        const length = this.likes.length
        for (let index = 0; index < length; index++) {
          const element = this.likes[index]
          list.push(element)
        }
        return list
      }
      return null
    },
    getTotalLike() {
      if (this.likes) {
        let total = 0
        for (let index = 0; index < this.likes.length; index++) {
          const element = this.likes[index]
          total += element[1]
        }
        return abbreviateNumber(total)
      }
      return 0
    },
    getTotalShare() {
      if (this.post) {
        return abbreviateNumber(this.post.shares || 0)
      }
      return 0
    }
  },
  created() {
    this.observer = new IntersectionObserver(this.onElementObserved, {
      root: null,
      rootMargin: '0px',
      threshold: 0.5
    })
  },
  mounted() {
    this.fetchPostById()
    this.getAllLike()
    this.observer.observe(this.$refs.post)
  },
  beforeDestroy() {
    try {
      this.observer.unobserve(this.$refs.post)
      this.observer = null
    } catch (err) {
      // eslint-disable-next-line no-console
      console.log(err)
    }
  },
  methods: {
    onElementObserved(entries) {
      const { player } = this.$refs
      if (entries[0].isIntersecting) {
        this.handlePlayed()
        if (player) {
          player[0].playVideo()
        }
      } else {
        if (player) {
          player[0].pauseVideo()
        }
      }
    },
    checkTypeImage(type) {
      return IMAGE_TYPES.some((x) => x === type)
    },
    checkTypeVideo(type) {
      return VIDEO_TYPES.some((x) => x === type)
    },
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
    getURL(data) {
      const [id, type] = data
      return getMediaLink(id, type)
    },
    getThumbnailURL(data) {
      const [id, type] = data
      return getThumbnailMediaLink(id, type)
    },
    // like
    async getAllLike() {
      this.likeLoading = true
      try {
        if (this.logged) {
          const liked = await checkLiked(this.postId)
          if (liked) {
            this.isLiked = liked[0]
          }
        }
        const data = await getAllLikeByPostId(this.postId)
        if (data) {
          this.likes = data
        }
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      } finally {
        this.likeLoading = false
      }
    },
    toggleLike(type) {
      if (!this.logged) {
        return this.$router.push({ name: 'login', query: { redirect: `/post/${this.postId}` } })
      }
      try {
        if (this.isLiked) {
          if (this.isLiked === type) {
            this.handleRemoveLike(type)
          } else {
            this.handleUpdateLike(type)
          }
        } else {
          this.handleCreateLike(type)
        }
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      }
    },
    async handleCreateLike(type) {
      if (!this.logged) {
        return this.$router.push({ name: 'login', query: { redirect: `/post/${this.postId}` } })
      }
      try {
        this.isLiked = type
        // update cache all like
        const lk = [type, 1]
        if (this.likes && this.likes.length) {
          let notExist = true
          const list = []
          for (let index = 0; index < this.likes.length; index++) {
            const element = this.likes[index]
            if (element[0] === type) {
              notExist = false
              element[1] += 1
            }
            list.push(element)
          }
          if (notExist) {
            list.push(lk)
          }
          this.likes = list
        } else {
          this.likes = [lk]
        }
        // fetch
        await createLike(this.postId, type, this.likes)
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      }
    },
    async handleUpdateLike(type) {
      if (!this.logged) {
        return this.$router.push({ name: 'login', query: { redirect: `/post/${this.postId}` } })
      }
      try {
        // update cache all like
        if (this.likes) {
          const list = []
          let notExist = true
          // remove
          for (let index = 0; index < this.likes.length; index++) {
            const element = this.likes[index]
            if (element[0] === this.isLiked) {
              if (element[1] === 1) {
                continue
              }
              element[1] -= 1
            }
            if (element[0] === type) {
              notExist = false
              element[1] += 1
            }
            list.push(element)
          }
          if (notExist) {
            list.push([type, 1])
          }
          this.likes = list
        }
        // update like
        this.isLiked = type
        // fetch
        await updateLike(this.postId, type, this.likes)
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      }
    },
    async handleRemoveLike(type) {
      if (!this.logged) {
        return this.$router.push({ name: 'login', query: { redirect: `/post/${this.postId}` } })
      }
      try {
        this.isLiked = null
        // update cache all like
        if (this.likes) {
          const list = []
          for (let index = 0; index < this.likes.length; index++) {
            const element = this.likes[index]
            if (element[0] === type) {
              if (element[1] === 1) {
                continue
              }
              element[1] -= 1
            }
            list.push(element)
          }
          this.likes = list
        }
        // fetch
        await removeLike(this.postId, this.likes)
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      }
    },
    // view
    handlePlayed() {
      try {
        setTimeout(() => updateView(this.postId), 200)
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
      const data = Buffer.from(JSON.stringify({ url: this.getShareURL() })).toString('base64')
      window.open(`https://sp.zalo.me/share?d=${data}`, 'Chia sẻ Zalo', 'popup')
      this.fetchShare()
    },
    copyLink() {
      this.showCopiedLink = true
      navigator.clipboard.writeText(this.getShareURL())
      setTimeout(() => {
        this.showCopiedLink = false
      }, 2000)
      this.fetchShare()
    }
  }
}
</script>
