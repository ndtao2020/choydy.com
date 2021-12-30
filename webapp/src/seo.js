const keyMeta = `fvxcfbl1bsi`

const createTag = (...obj) => {
  const tag = document.createElement('meta')
  obj.forEach(([key, value]) => tag.setAttribute(key, value))
  tag.setAttribute(keyMeta, '')
  document.head.appendChild(tag)
}

const changeTitle = (meta, path) => {
  if (!meta) return
  const { title, description, image, video } = meta
  // Turn the meta tag definitions into actual elements in the head.
  // Remove any stale meta tags from the document using the key attribute we set below.
  Array.from(document.querySelectorAll(`[${keyMeta}]`)).map((el) => el.parentNode.removeChild(el))
  // set up title
  if (title) {
    const value = `${title || '404'} | ChoyDy.Com - Meme hài hước`
    document.title = value
    createTag(['name', 'title'], ['content', value])
    createTag(['property', 'og:title'], ['content', value])
    createTag(['property', 'twitter:title'], ['content', value])
  }
  // set up description
  if (description) {
    createTag(['name', 'description'], ['content', description])
    createTag(['property', 'og:description'], ['content', description])
    createTag(['property', 'twitter:description'], ['content', description])
  }
  // domain
  const domain = process.env.VUE_APP_PROXY
  // set image
  const img = image || '/img/logo/full-logo-share.png'
  createTag(['name', 'og:image'], ['content', domain + img])
  createTag(['name', 'twitter:image'], ['content', domain + img])
  // set url
  if (path) {
    createTag(['name', 'og:url'], ['content', domain + path])
    createTag(['name', 'twitter:url'], ['content', domain + path])
  }
  // set video
  if (video) {
    createTag(['name', 'og:type'], ['content', 'video'])
    createTag(['name', 'og:video'], ['content', domain + video])
    createTag(['name', 'og:video:width'], ['content', '600'])
    createTag(['name', 'og:video:height'], ['content', '500'])
    createTag(['name', 'twitter:video'], ['content', domain + video])
  } else {
    createTag(['name', 'og:type'], ['content', 'website'])
  }
  // others
  createTag(['name', 'twitter:card'], ['content', 'summary_large_image'])
}

export default changeTitle
