<template>
  <section class="widget">
    <slot v-bind="$children" />
  </section>
</template>

<script>
export default {
  name: 'AdminWidget'
}
</script>
<style lang="scss" scoped>
.widget {
  display: block;
  position: relative;
  margin-bottom: 40px;
  padding: 15px 20px;
  background: #fff;
  border-radius: 0.45rem;
  -webkit-box-shadow: var(--widget-shadow);
  box-shadow: var(--widget-shadow);
}
</style>
