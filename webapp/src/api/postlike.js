import configDB from '@/database/base/config'
import { searchData, saveData } from '@/database'
import { publicGet, authGet, authPost, authPut, authDel } from '@/request'

const {
  postlike: { name, exp }
} = configDB

const getAllLikeByPostId = async (id) => {
  let postlike
  try {
    const d = await searchData(name, id)
    if (d) {
      postlike = d.data
    }
  } catch (error) {
    postlike = null
    // eslint-disable-next-line no-console
    console.log(error)
  }
  if (!postlike) {
    try {
      const data = await publicGet(`/post/like?i=${id}`)
      await saveData(name, exp, { id, data })
      return data
      // eslint-disable-next-line no-empty
    } catch {}
  }
  return postlike
}
// logged
const checkLiked = (postId) => authGet(`/postlike?i=${postId}`)
const createLike = async (postId, type) => {
  try {
    authPost(`/postlike?i=${postId}&t=${type}`)
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}
const updateLike = (postId, type) => {
  try {
    authPut(`/postlike?i=${postId}&t=${type}`)
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}
const removeLike = async (postId) => {
  try {
    authDel(`/postlike?i=${postId}`)
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}
// export
export { getAllLikeByPostId, checkLiked, createLike, updateLike, removeLike }
