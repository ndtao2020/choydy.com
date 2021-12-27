import { publicGet } from '@/request'
import configDB from '@/database/base/config'
import { searchData, saveData } from '@/database'

const {
  user: { name, exp }
} = configDB

const getUserById = async (id) => {
  let user = null
  try {
    const d = await searchData(name, id)
    if (d) {
      user = d.data
    }
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
  if (!user) {
    const data = await publicGet(`/user?i=${id}`)
    try {
      await saveData(name, exp, { id, data })
      // eslint-disable-next-line no-empty
    } catch {}
    return data
  }
  return user
}

export { getUserById }
