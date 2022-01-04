import configDB from '@/database/base/config'
import { publicGet, publicPost, authPost, authPut, authDel } from '@/request'
import { searchData, saveData, updateData } from '@/database'

const url = `/post`
const {
  post: { name, exp }
} = configDB

const getPosts = (page, size, catalogId, search) => {
  let u = `${url}?p=${page}&s=${size}`
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
// ======================================== Like
const getAllLikeByPostId = (id) => publicGet(`${url}/like?i=${id}`)
const createLike = async (postId, type) => {
  const post = await getPostById(postId)
  if (!post) {
    throw new Error('Post Id does not exist !')
  }
  try {
    authPost(`/postlike?i=${postId}&t=${type}`)
    post.likes += 1
    await updateData(name, exp, post)
    // eslint-disable-next-line no-empty
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}
const updateLike = async (postId, type) => {
  const post = await getPostById(postId)
  if (!post) {
    throw new Error('Post Id does not exist !')
  }
  try {
    authPut(`/postlike?i=${postId}&t=${type}`)
    post.likes += 1
    await updateData(name, exp, post)
    // eslint-disable-next-line no-empty
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}
const removeLike = async (postId) => {
  const post = await getPostById(postId)
  if (!post) {
    throw new Error('Post Id does not exist !')
  }
  try {
    authDel(`/postlike?i=${postId}`)
    if (post.likes) {
      post.likes -= 1
    }
    await updateData(name, exp, post)
    // eslint-disable-next-line no-empty
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}
// export
export {
  getPosts,
  getPostById,
  findAllTagByPostId,
  findAllMediaByPostId,
  getMediaLink,
  getAllLikeByPostId,
  updateShare,
  createLike,
  updateLike,
  removeLike
}
