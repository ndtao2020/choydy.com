const keyMeta = `FvxcFbL1BSizNhO2svY`

const changeTitle = (meta) => {
  // set up title
  document.title = `${meta.title || '404'} | ChoyDy.Com - Meme hài hước`
  // Turn the meta tag definitions into actual elements in the head.
  // Remove any stale meta tags from the document using the key attribute we set below.
  Array.from(document.querySelectorAll(`[${keyMeta}]`)).map((el) => el.parentNode.removeChild(el))
  // set meta tags
  meta.metaTags &&
    meta.metaTags
      .map((tagDef) => {
        const tag = document.createElement('meta')
        Object.keys(tagDef).forEach((key) => tag.setAttribute(key, tagDef[key]))
        tag.setAttribute(keyMeta, '')
        return tag
      })
      // Add the meta tags to the document head.
      .forEach((tag) => document.head.appendChild(tag))
}

export default changeTitle
