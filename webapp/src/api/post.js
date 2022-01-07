import configDB from '@/database/base/config'
import { publicGet, publicPost } from '@/request'
import { searchData, saveData, updateData } from '@/database'

const url = `/post`
const {
  post: { name, exp }
} = configDB

const getPosts = (page, catalogId, search) => {
  let u = `${url}?p=${page}`
  if (catalogId) {
    u += `&c=${catalogId}`
  }
  if (search) {
    u += `&k=${search}`
  }
  return publicGet(u)
}
const getPostById = async (id) => {
  let post
  try {
    post = await searchData(name, id)
  } catch (error) {
    post = null
    // eslint-disable-next-line no-console
    console.log(error)
  }
  if (!post) {
    const data = await publicGet(`${url}/id?i=${id}`)
    try {
      await saveData(name, exp, data)
      // eslint-disable-next-line no-empty
    } catch {}
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
  const tags = await publicGet(`/post/tag?i=${postId}`)
  post.tags = tags
  try {
    await updateData(name, exp, post)
    // eslint-disable-next-line no-empty
  } catch {}
  return tags
}
// ======================================== Media
const getMediaLink = (id, type) => `/media/${id}?t=${type}`
const findAllMediaByPostId = async (postId) => {
  const post = await getPostById(postId)
  if (!post) {
    throw new Error('Post Id does not exist !')
  }
  const media = await publicGet(`/post/media?i=${postId}`)
  post.media = media
  try {
    await updateData(name, exp, post)
    // eslint-disable-next-line no-empty
  } catch {}
  return media
}
// ======================================== Share
const updateShare = async (postId) => {
  const post = await getPostById(postId)
  if (!post) {
    throw new Error('Post Id does not exist !')
  }
  try {
    publicPost(`${url}/share?i=${postId}`)
    post.shares += 1
    await updateData(name, exp, post)
    // eslint-disable-next-line no-empty
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}
// export
export { getPosts, getPostById, findAllTagByPostId, findAllMediaByPostId, getMediaLink, updateShare }
