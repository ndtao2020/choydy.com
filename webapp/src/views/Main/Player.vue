<template>
  <div ref="player" class="player">
    <div class="player__sizer">
      <video
        ref="video"
        loop
        @play="onVideoPlay"
        @pause="onVideoPause"
        @click="togglePlay"
        @volumechange="onVideoVolumeChange"
        @loadedmetadata="onVideoLoadedMetaData"
        @timeupdate="onVideoTimeUpdate"
        @progress="onVideoProgress"
        @loadstart="isLoading = true"
        @loadeddata="isLoading = false"
        @waiting="isWaiting = true"
        @canplay="isWaiting = false"
      >
        <source :type="type" :src="src" />
      </video>
    </div>
    <div class="player__gradient" />
    <div v-show="isLoading || isWaiting" class="player__loader">
      <img src="@/assets/images/logo.png" class="img-fluid" alt="logo" width="160" height="45" />
    </div>
    <div class="d-flex player__controls py-2">
      <div class="ml-2" @click="togglePlay">
        <img v-if="isPlaying" src="@/assets/icons/player/pause.svg" width="25" height="25" />
        <img v-else src="@/assets/icons/player/play.svg" width="25" height="25" />
      </div>
      <slider v-if="!hideProgress" class="mx-3 my-auto player__seeker" :max="duration" :value="currentTime" @input="seek">
        <template #bar>
          <div class="player__seeker-buffered" :style="bufferedStyle" />
        </template>
      </slider>
      <!-- <div v-if="!hideProgress" class="mr-2 mx-auto player__time">{{ currentTimeFormatted }}</div> -->
      <div class="ml-auto mx-3" @click="toggleSound">
        <img v-if="playerIsMuted" src="@/assets/icons/player/mute.svg" width="25" height="25" />
        <img v-else src="@/assets/icons/player/volume.svg" width="25" height="25" />
      </div>
      <slider
        class="player__sound-slider mr-3 my-auto"
        :style="{ width: '80px' }"
        :value="playerIsMuted ? 0 : playerVolume"
        @input="onVolumeSliderChange"
      />
    </div>
  </div>
</template>

<script>
import { mapState, mapMutations } from 'vuex'
import Slider from './Slider'

export default {
  name: 'MediaPlayer',
  components: { Slider },
  props: {
    type: String,
    src: String,
    hideProgress: Boolean
  },
  data() {
    return {
      observer: null,
      isPlaying: false,
      // isFullscreen: false,
      isLoading: false,
      isWaiting: false,
      duration: 0,
      currentTime: 0,
      buffered: 0
    }
  },
  computed: {
    ...mapState('layout', ['playerVolume', 'playerIsMuted']),
    // currentTimeFormatted() {
    //   return this.hhmmss(Math.round(this.currentTime))
    // },
    // durationFormatted() {
    //   return this.hhmmss(Math.round(this.duration))
    // },
    bufferedStyle() {
      return {
        transformOrigin: 'left center',
        transform: `scaleX(${this.buffered})`
      }
    }
  },
  watch: {
    source() {
      this.isPlaying = false
      this.isWaiting = false
      this.buffered = 0
      this.currentTime = 0
      this.$nextTick(() => {
        this.$refs.video.load()
      })
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
    document.addEventListener('keyup', this.onDocumentKeyUp)
    // screenfull.onchange(this.onFullscreenChange)
    this.observer.observe(this.$refs.player)
  },
  beforeDestroy() {
    this.observer.unobserve(this.$refs.player)
    this.observer = null
  },
  methods: {
    ...mapMutations('layout', ['changePlayerVolume', 'changePlayerIsMuted']),
    onDocumentKeyUp(e) {
      if (e.keyCode === 32) {
        this.togglePlay()
      }
    },
    onElementObserved(entries) {
      const { video } = this.$refs
      if (!video) {
        return
      }
      if (entries[0].isIntersecting) {
        this.playVideo(video)
      } else {
        this.pauseVideo(video)
      }
    },
    onVideoPlay() {
      this.isPlaying = true
    },
    onVideoPause() {
      this.isPlaying = false
    },
    onVideoLoadedMetaData() {
      const { video } = this.$refs
      if (!video) {
        return
      }
      this.duration = video.duration
      this.currentTime = video.currentTime
    },
    onVideoTimeUpdate() {
      const { video } = this.$refs
      if (!video) {
        return
      }
      if (video) {
        this.currentTime = video.currentTime
      }
    },
    onVideoVolumeChange() {
      const { video } = this.$refs
      if (!video) {
        return
      }
      this.changePlayerVolume(video.volume)
      this.changePlayerIsMuted(video.muted)
    },
    onVolumeSliderChange(value) {
      const { video } = this.$refs
      if (video.muted && value > 0) {
        video.muted = false
      }
      if (value <= 0) {
        video.muted = true
        localStorage.setItem('vol', 0)
      }
      // video.volume = value
      this.changePlayerVolume(value)
      localStorage.setItem('vol', value)
    },
    onFullscreenChange() {
      //   this.isFullscreen = this.$el === screenfull.element
    },
    onVideoProgress() {
      const { video } = this.$refs
      if (!video) {
        return
      }
      const { duration } = video
      if (duration > 0) {
        const { currentTime, buffered } = video
        const bufferedLength = buffered.length
        for (let i = 0; i < bufferedLength; i++) {
          const start = buffered.start(i)
          const end = buffered.end(i)
          if (start < currentTime && end > currentTime) {
            this.buffered = end / duration
          }
        }
      }
    },
    togglePlay() {
      const { video } = this.$refs
      if (video.paused) {
        this.playVideo(video)
      } else {
        this.pauseVideo(video)
      }
    },
    toggleSound() {
      const { video } = this.$refs
      if (video.volume <= 0) {
        video.volume = 0.5
      }
      video.muted = !video.muted
    },
    toggleFullscreen() {
      //   if (!screenfull.isEnabled) return
      //   const { $el } = this
      //   if (screenfull.element === $el) {
      //     screenfull.exit()
      //   } else {
      //     screenfull.request($el)
      //   }
    },
    playVideo(video) {
      video.volume = this.playerVolume
      video.muted = this.playerIsMuted
      video.play()
    },
    pauseVideo(video) {
      video.pause()
    },
    seek(time) {
      const { video } = this.$refs
      if (!video) {
        return
      }
      this.currentTime = time
      video.currentTime = time
    },
    pad(num) {
      return ('0' + num).slice(-2)
    },
    hhmmss(secs) {
      const minutes = Math.floor(secs / 60)
      return `${this.pad(minutes % 60)}:${this.pad(secs % 60)}`
    }
  }
}
</script>

<style lang="scss" scoped>
.player {
  position: relative;
  width: 100%;
  max-height: 500px;
  video {
    width: 100%;
    height: 100%;
  }
  &__sizer {
    position: relative;
    width: 100%;
    height: 100%;
  }
  &__loader {
    position: absolute;
    top: calc(50% - 64px);
    left: calc(50% - 64px);
    z-index: 1;
  }
  &__gradient {
    background: linear-gradient(0deg, #b5b5b5, transparent);
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: 0;
    height: 35px;
    opacity: 0.9;
    pointer-events: none;
  }
  &__controls {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    img {
      width: 25px;
      height: 25px;
    }
  }
  &__seeker-buffered {
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(#fff, 0.25);
    z-index: 0;
  }
  &__time {
    color: #fff;
  }
}
</style>
