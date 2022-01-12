import { searchData, saveData, updateData } from '@/database'
import { publicGet, authGet, authPost, authPut, authDel } from '@/request'

const dbName = `postlike`

const getAllLikeByPostId = async (id) => {
  let postlike = null
  try {
    const d = await searchData(dbName, id)
    if (d) {
      postlike = d.data
    }
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
  if (postlike === null) {
    try {
      const data = await publicGet(`/post/like?i=${id}`)
      if (data) {
        await saveData(dbName, { id, data })
      }
      return data
      // eslint-disable-next-line no-empty
    } catch {}
  }
  return postlike
}
// logged
const checkLiked = (postId) => authGet(`/${dbName}?i=${postId}`)
const createLike = async (postId, type, data) => {
  try {
    await updateData(dbName, { id: postId, data })
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
  await authPost(`/${dbName}?i=${postId}&t=${type}`)
}
const updateLike = async (postId, type, data) => {
  try {
    await updateData(dbName, { id: postId, data })
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
  await authPut(`/${dbName}?i=${postId}&t=${type}`)
}
const removeLike = async (postId, data) => {
  try {
    await updateData(dbName, { id: postId, data })
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
  await authDel(`/${dbName}?i=${postId}`)
}
// export
export { getAllLikeByPostId, checkLiked, createLike, updateLike, removeLike }
