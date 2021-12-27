import { publ, publicGet } from '@/request'
import configDB from '@/database/base/config'
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
// tag
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
// media
const getMediaLink = (id, type) => publ(`/media?i=${id}&t=${type}`)
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
// Like
const getAllLikeTypes = () => publicGet(`${url}/like/type`)
const getAllLikeByPostId = (id) => publicGet(`${url}/like?i=${id}`)
// export
export { getPosts, getPostById, findAllTagByPostId, findAllMediaByPostId, getMediaLink, getAllLikeTypes, getAllLikeByPostId }
