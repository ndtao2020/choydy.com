<template>
  <div class="right-sidebar-mini">
    <div class="right-sidebar-panel p-0">
      <div class="iq-card shadow-none">
        <div ref="adsterra2" class="p-0"></div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MainRightSideBar',
  mounted() {
    // adsterra.com
    const { adsterra2 } = this.$refs
    if (adsterra2) {
      const adst = document.createElement('script')
      adst.setAttribute('type', 'text/javascript')
      adst.setAttribute(
        'src',
        `http${location.protocol === 'https:' ? 's' : ''}://www.effectivedisplaycontent.com/3a19a2181b43f1ab7a819cc0aca3c235/invoke.js`
      )
      adsterra2.appendChild(adst)
    }
  }
}
</script>
