import * as req from '@/request'

const getCatalogs = () => req.get('/public/catalog')

export { getCatalogs }
