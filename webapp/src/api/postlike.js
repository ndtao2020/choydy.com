import { searchData, saveData } from '@/database'
import { publicGet, authGet, authPost, authPut, authDel } from '@/request'

const dbName = `postlike`

const getAllLikeByPostId = async (id) => {
  let postlike
  try {
    const d = await searchData(dbName, id)
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
      await saveData(dbName, { id, data })
      return data
      // eslint-disable-next-line no-empty
    } catch {}
  }
  return postlike
}
// logged
const checkLiked = (postId) => authGet(`/${dbName}?i=${postId}`)
const createLike = async (postId, type) => {
  try {
    authPost(`/${dbName}?i=${postId}&t=${type}`)
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}
const updateLike = (postId, type) => {
  try {
    authPut(`/${dbName}?i=${postId}&t=${type}`)
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}
const removeLike = async (postId) => {
  try {
    authDel(`/${dbName}?i=${postId}`)
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}
// export
export { getAllLikeByPostId, checkLiked, createLike, updateLike, removeLike }
