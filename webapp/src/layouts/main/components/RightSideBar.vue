<template>
  <div class="right-sidebar-mini">
    <div class="right-sidebar-panel p-0">
      <div class="iq-card shadow-none">
        <div ref="adsense" class="p-0"></div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MainRightSideBar',
  mounted() {
    const { adsense } = this.$refs
    // adsense
    if (adsense) {
      const adst = document.createElement('script')
      adst.setAttribute('async', '')
      adst.setAttribute('src', `https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-5727937131697376`)
      adst.setAttribute('crossorigin', `anonymous`)
      adsense.appendChild(adst)

      const ins = document.createElement('ins')
      ins.setAttribute('class', 'adsbygoogle')
      ins.setAttribute('style', `display: block`)
      ins.setAttribute('data-ad-format', `auto`)
      ins.setAttribute('data-full-width-responsive', `true`)
      ins.setAttribute('data-ad-client', `ca-pub-5727937131697376`)
      ins.setAttribute('data-ad-slot', `7686420346`)
      adsense.appendChild(ins)

      const scp = document.createElement('script')
      scp.text = ';(adsbygoogle = window.adsbygoogle || []).push({})'
      adsense.appendChild(scp)
    }
  }
}
</script>
