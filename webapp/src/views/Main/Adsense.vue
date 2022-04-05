<template>
  <div ref="adsbygoog" />
</template>

<script>
import { GOOGLE_AD_CLIENT } from '@/constants'

export default {
  name: 'GGAdsense',
  mounted() {
    const { adsbygoog } = this.$refs
    // ================ GG Adsense 1 ================
    if (adsbygoog) {
      // script
      const script = document.createElement('script')
      script.setAttribute('async', '')
      script.setAttribute('src', `https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=${GOOGLE_AD_CLIENT}`)
      script.setAttribute('crossorigin', 'anonymous')
      adsbygoog.appendChild(script)
      // ins
      const ins = document.createElement('ins')
      ins.setAttribute('class', 'adsbygoogle')
      ins.setAttribute('style', `display: block; text-align: center`)
      ins.setAttribute('data-ad-layout', `in-article`)
      ins.setAttribute('data-ad-format', `fluid`)
      ins.setAttribute('data-ad-client', GOOGLE_AD_CLIENT)
      ins.setAttribute('data-ad-slot', '7602428355')
      adsbygoog.appendChild(ins)
      // script2
      const script2 = document.createElement('script')
      script2.text = `(adsbygoogle = window.adsbygoogle || []).push({});`
      adsbygoog.appendChild(script2)
    }
  }
}
</script>
