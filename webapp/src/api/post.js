import { publicGet, publicPost } from '@/request'
import { searchData, saveData, updateData } from '@/database'

const dbName = `post`

const getPosts = (page, catalogId, search) => {
  let u = `/${dbName}?p=${page}`
  if (catalogId) {
    u += `&c=${catalogId}`
  }
  if (search) {
    u += `&k=${search}`
  }
  return publicGet(u)
}
const getRecommends = (id) => publicGet(`/${dbName}/recommend?i=${id}`)
const getPostById = async (id) => {
  let post
  try {
    post = await searchData(dbName, id)
  } catch (error) {
    post = null
    // eslint-disable-next-line no-console
    console.log(error)
  }
  if (!post) {
    const data = await publicGet(`/${dbName}/id?i=${id}`)
    if (data) {
      try {
        await saveData(dbName, data)
        // eslint-disable-next-line no-empty
      } catch {}
    }
    return data
  }
  return post
}
// ======================================== Tag
const findAllTagByPostId = async (postId) => {
  const post = await getPostById(postId)
  if (!post) {
    throw new Error('Post Id does not exist !')
  }
  const tags = await publicGet(`/${dbName}/tag?i=${postId}`)
  post.tags = tags
  try {
    await updateData(dbName, post)
    // eslint-disable-next-line no-empty
  } catch {}
  return tags
}
// ======================================== Media
const getMediaLink = (id, type) => `/media/${id}?t=${type}`
const getThumbnailMediaLink = (id, type) => `/media/c/${id}?t=${type}`
const findAllMediaByPostId = async (postId) => {
  const post = await getPostById(postId)
  if (!post) {
    throw new Error('Post Id does not exist !')
  }
  const media = await publicGet(`/${dbName}/media?i=${postId}`)
  post.media = media
  try {
    await updateData(dbName, post)
    // eslint-disable-next-line no-empty
  } catch {}
  return media
}
// ======================================== View & Share
const updateView = async (postId) => {
  const post = await getPostById(postId)
  if (!post) {
    throw new Error('Post Id does not exist !')
  }
  try {
    publicPost(`/${dbName}/view?i=${postId}`)
    post.count += 1
    await updateData(dbName, post)
    // eslint-disable-next-line no-empty
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}
const updateShare = async (postId) => {
  const post = await getPostById(postId)
  if (!post) {
    throw new Error('Post Id does not exist !')
  }
  try {
    publicPost(`/${dbName}/share?i=${postId}`)
    post.shares += 1
    await updateData(dbName, post)
    // eslint-disable-next-line no-empty
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}
// export
export {
  getPosts,
  getRecommends,
  getPostById,
  findAllTagByPostId,
  findAllMediaByPostId,
  getMediaLink,
  getThumbnailMediaLink,
  updateView,
  updateShare
}
