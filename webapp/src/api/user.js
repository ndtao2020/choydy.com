import { publicGet } from '@/request'
import { searchData, saveData } from '@/database'

const dbName = `user`

const getUserById = async (id) => {
  let user = null
  try {
    const d = await searchData(dbName, id)
    if (d) {
      user = d.data
    }
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
  if (!user) {
    const data = await publicGet(`/${dbName}?i=${id}`)
    try {
      await saveData(dbName, { id, data })
      // eslint-disable-next-line no-empty
    } catch {}
    return data
  }
  return user
}

export { getUserById }
