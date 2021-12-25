<template>
  <div :class="classes" @mousedown="onSliderMouseDown" @click="onSliderClick">
    <div ref="bar" class="slider__bar">
      <div ref="handle" class="slider__handle" :style="handleStyle" />
      <div class="slider__fill" :style="fillStyle" />
      <slot name="bar" />
    </div>
  </div>
</template>

<script>
import lerp from 'lerp'
import clamp from 'lodash/clamp'
import throttle from 'lodash/throttle'

export default {
  name: 'MediaSlider',
  props: {
    min: {
      type: Number,
      default: 0
    },
    max: {
      type: Number,
      default: 1
    },
    value: Number,
    disabled: Boolean
  },
  data: () => ({
    isDragging: false,
    handleWidth: 0,
    barWidth: 0,
    dragTimeout: null
  }),
  computed: {
    classes() {
      return {
        slider: true,
        'slider--dragging': this.isDragging,
        'slider--disabled': this.disabled
      }
    },
    delta() {
      return this.value / this.max
    },
    fillStyle() {
      return {
        transformOrigin: 'left center',
        transform: `scaleX(${this.delta})`
      }
    },
    handleStyle() {
      const { barWidth, delta, handleWidth } = this
      return {
        transform: `translateX(${barWidth * delta - handleWidth * 0.5}px)`
      }
    }
  },
  mounted() {
    this.onWindowResize = throttle(this.onWindowResize, 200)
    this.calcDimensions()
    window.addEventListener('resize', this.onWindowResize)
    document.addEventListener('mouseup', this.onDocumentMouseUp)
    document.addEventListener('mousemove', this.onDocumentMouseMouseMove)
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.onWindowResize)
    document.removeEventListener('mouseup', this.onDocumentMouseUp)
    document.removeEventListener('mousemove', this.onDocumentMouseMouseMove)
  },
  methods: {
    onWindowResize() {
      this.calcDimensions()
    },
    onDocumentMouseMouseMove(e) {
      if (this.disabled || !this.isDragging) return
      this.calculate(e)
    },
    onDocumentMouseUp() {
      if (this.disabled) return
      if (this.dragTimeout) {
        clearTimeout(this.dragTimeout)
        this.$emit('click')
      } else {
        this.isDragging = false
        this.$emit('dragend')
      }
    },
    onSliderClick(e) {
      if (this.disabled) return
      this.calculate(e)
    },
    onSliderMouseDown() {
      if (this.disabled) return
      this.dragTimeout = setTimeout(() => {
        this.isDragging = true
        this.dragTimeout = null
        this.$emit('dragstart')
      }, 100)
    },
    calcDimensions() {
      const { bar, handle } = this.$refs
      this.handleWidth = handle.offsetWidth
      this.barWidth = bar.offsetWidth
    },
    calculate(e) {
      const { bar } = this.$refs
      const { barWidth } = this
      const relativeX = this.getRelativeXPosition(e, bar)
      const delta = relativeX / barWidth
      this.$emit('input', lerp(this.min, this.max, delta))
    },
    offsetX(el) {
      const { left } = el.getBoundingClientRect()
      const { scrollLeft } = document.documentElement
      return left + scrollLeft
    },
    getRelativeXPosition(e, target) {
      const elOffsetX = this.offsetX(target)
      const elWidth = target.offsetWidth
      const value = e.pageX - elOffsetX
      return clamp(value, 0, elWidth)
    }
  }
}
</script>

<style lang="scss" scoped>
.slider {
  $this: &;
  cursor: pointer;
  width: 100%;
  display: flex;
  align-items: center;
  height: 24px;
  &--dragging {
    #{$this}__handle,
    #{$this}__fill {
      transition: none;
    }
  }
  &__fill,
  &__handle {
    transition: transform 0.2s ease-in-out;
  }
  &__bar {
    position: relative;
    width: 100%;
    height: 4px;
    background-color: rgba(#fff, 0.2);
  }
  &__handle {
    width: 14px;
    height: 14px;
    border-radius: 50%;
    background-color: #fff;
    position: absolute;
    left: 0;
    top: calc(50% - 7px);
    z-index: 2;
  }
  &__fill {
    position: relative;
    height: 100%;
    width: 100%;
    background-color: rgb(107, 200, 228);
    z-index: 1;
    transform: scaleX(0);
  }
}
</style>
