import { publicGet } from '@/request'

const getCatalogs = () => publicGet('/catalog')
const getCatalogById = (id) => publicGet(`/catalog/id?i=${id}`)

export { getCatalogs, getCatalogById }
