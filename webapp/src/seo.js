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
    const script = document.createElement('script')
    script.setAttribute('async', '')
    script.setAttribute('src', 'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-5727937131697376')
    script.setAttribute('crossorigin', 'anonymous')
    if (process.env.NODE_ENV === 'production') {
      document.head.appendChild(script)
    }
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
