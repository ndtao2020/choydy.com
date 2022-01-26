import { GOOGLE_AD_CLIENT } from '@/constants'

const keyMeta = `fvxcfbl1bsi`

const createTag = (...obj) => {
  const tag = document.createElement('meta')
  obj.forEach(([key, value]) => tag.setAttribute(key, value))
  tag.setAttribute(keyMeta, '')
  document.head.appendChild(tag)
}

const changeTitle = (meta) => {
  if (!meta) return
  const { title, adsense } = meta
  // set up adsense
  if (adsense) {
    // script
    const script = document.createElement('script')
    // script.setAttribute('async', '')
    script.setAttribute('src', `https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=${GOOGLE_AD_CLIENT}`)
    script.setAttribute('crossorigin', 'anonymous')
    document.head.appendChild(script)
    // content
    // const script2 = document.createElement('script')
    // script2.text = `(adsbygoogle=window.adsbygoogle||[]).push({google_ad_client:"${GOOGLE_AD_CLIENT}",enable_page_level_ads:!0});`
    // document.head.appendChild(script2)
  }
  // set up title
  if (title) {
    // Turn the meta tag definitions into actual elements in the head.
    // Remove any stale meta tags from the document using the key attribute we set below.
    Array.from(document.querySelectorAll(`[${keyMeta}]`)).map((el) => el.parentNode.removeChild(el))
    const value = `${title || '404'} | ChoyDy.Com - Meme hài hước`
    document.title = value
    createTag(['name', 'title'], ['content', value])
    createTag(['property', 'og:title'], ['content', value])
    createTag(['property', 'twitter:title'], ['content', value])
  }
}

export default changeTitle
