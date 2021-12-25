<template>
  <div class="iq-card">
    <div v-if="$slots.title" class="iq-card-header d-flex justify-content-between">
      <div class="iq-header-title">
        <slot name="title" />
      </div>
    </div>
    <div v-if="$slots.body" :class="'iq-card-body ' + bodyClass">
      <slot name="body" />
    </div>
    <slot />
  </div>
</template>

<script>
export default {
  props: {
    bodyClass: { type: String, default: '' }
  }
}
</script>
