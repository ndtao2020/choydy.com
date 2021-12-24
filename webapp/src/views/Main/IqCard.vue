<template>
  <div class="iq-card">
    <slot name="cardImage" />
    <div v-if="$slots.title" class="iq-card-header d-flex justify-content-between">
      <div class="iq-header-title">
        <slot name="title" />
      </div>
    </div>
    <b-card-body v-if="$slots.body" :body-class="'iq-card-body ' + bodyClass">
      <slot name="body" />
    </b-card-body>
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
