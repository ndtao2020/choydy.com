import { publicGet } from '@/request'
import { searchData, saveData } from '@/database'

const dbName = `catalog`

const getCatalogs = () => publicGet(`/${dbName}`)
const getCatalogById = async (id) => {
  let catalog = null
  try {
    const d = await searchData(dbName, id)
    if (d) {
      catalog = d.data
    }
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
  if (!catalog) {
    const data = await publicGet(`/${dbName}/id?i=${id}`)
    try {
      await saveData(dbName, { id, data })
      // eslint-disable-next-line no-empty
    } catch {}
    return data
  }
  return catalog
}

export { getCatalogs, getCatalogById }
