<template>
  <div class="right-sidebar-mini">
    <div class="right-sidebar-panel p-0">
      <div class="iq-card shadow-none">
        <div class="p-0" v-html="renderAD()"></div>
      </div>
    </div>
  </div>
</template>

<script>
import { rend } from '../rednerAD'

export default {
  name: 'MainRightSideBar',
  methods: {
    renderAD() {
      return rend()
    }
  }
}
</script>
