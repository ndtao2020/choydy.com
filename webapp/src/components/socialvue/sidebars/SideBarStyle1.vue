<template>
  <div class="iq-sidebar">
    <div id="sidebar-scrollbar">
      <nav class="iq-sidebar-menu">
        <List :items="items" :open="true" :horizontal="horizontal" />
      </nav>
    </div>
  </div>
</template>

<script>
export default {
  components: {
    List: () => import('../menus/ListStyle1')
  },
  props: {
    items: { type: Array },
    horizontal: { type: Boolean }
  }
}
</script>
