<template>
  <div class="player">
    <div class="player__sizer">
      <video
        ref="video"
        loop
        :poster="poster"
        @play="onVideoPlay"
        @pause="onVideoPause"
        @click="togglePlay"
        @volumechange="onVideoVolumeChange"
        @loadedmetadata="onVideoLoadedMetaData"
        @timeupdate="onVideoTimeUpdate"
        @progress="onVideoProgress"
        @loadstart="isLoading = true"
        @loadeddata="onLoadedData"
        @waiting="isWaiting = true"
        @canplay="isWaiting = false"
      >
        <source :type="type" :src="src" />
      </video>
    </div>
    <div class="player__gradient" />
    <div v-show="isLoading || isWaiting" class="player__loader">
      <!-- <img src="@/assets/images/logo.png" class="img-fluid" alt="logo" width="160" height="45" /> -->
      <div class="spinner-grow text-primary" role="status" />
      <div class="spinner-grow text-success" role="status" />
      <div class="spinner-grow text-danger" role="status" />
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
    poster: String,
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
  mounted() {
    document.addEventListener('keyup', this.onDocumentKeyUp)
  },
  beforeDestroy() {
    document.removeEventListener('keyup', this.onDocumentKeyUp)
  },
  methods: {
    ...mapMutations('layout', ['changePlayerVolume', 'changePlayerIsMuted']),
    onDocumentKeyUp(e) {
      if (e.keyCode === 32) {
        this.togglePlay()
      }
    },
    onVideoPlay() {
      this.isPlaying = true
    },
    onVideoPause() {
      this.isPlaying = false
    },
    onLoadedData() {
      this.isLoading = false
      try {
        caches
          .open('video')
          .then((zzzz) => zzzz.add(this.src))
          // eslint-disable-next-line no-console
          .catch((err) => console.log(err))
      } catch (err) {
        // eslint-disable-next-line no-console
        console.log(err)
      }
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
      this.changePlayerVolume(video.volume)
      this.changePlayerIsMuted(video.muted)
    },
    playVideo(obj) {
      let vid
      if (obj) {
        vid = obj
      } else {
        const { video } = this.$refs
        if (!video) {
          return
        }
        vid = video
      }
      vid.volume = this.playerVolume
      vid.muted = this.playerIsMuted
      vid.play()
    },
    pauseVideo(obj) {
      let vid
      if (obj) {
        vid = obj
      } else {
        const { video } = this.$refs
        if (!video) {
          return
        }
        vid = video
      }
      vid.pause()
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
  min-height: 250px;
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
