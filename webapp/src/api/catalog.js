import * as req from '@/request'

const getCatalogs = () => req.get('/public/catalog')
const getCatalogById = (id) => req.get(`/public/catalog/id?id=${id}`)

export { getCatalogs, getCatalogById }
