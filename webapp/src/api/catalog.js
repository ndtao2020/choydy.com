import { publicGet } from '@/request'
import configDB from '@/database/base/config'
import { searchData, saveData } from '@/database'

const {
  catalog: { name, exp }
} = configDB

const getCatalogs = () => publicGet('/catalog')
const getCatalogById = async (id) => {
  let catalog = null
  try {
    const d = await searchData(name, id)
    if (d) {
      catalog = d.data
    }
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
  if (!catalog) {
    const data = await publicGet(`/catalog/id?i=${id}`)
    try {
      await saveData(name, exp, { id, data })
      // eslint-disable-next-line no-empty
    } catch {}
    return data
  }
  return catalog
}

export { getCatalogs, getCatalogById }
