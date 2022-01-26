import store from '@/store'
import config from './config'

export const openConnection = () =>
  new Promise((resolve, reject) => {
    try {
      const request = window.indexedDB.open('d39zbi81v', 2)
      request.onupgradeneeded = (event) => {
        const db = event.target.result
        // check new version
        if (event.oldVersion !== event.newVersion) {
          for (const property in config) {
            const obj = config[property]
            try {
              db.createObjectStore(property, obj.options)
            } catch (err) {
              // eslint-disable-next-line no-console
              console.log(err)
            }
          }
        }
      }
      request.onsuccess = (event) => resolve(event.target.result)
      request.onerror = () => reject(request.error)
    } catch (error) {
      reject(error)
    }
  })

export const findAll = (collectionName) =>
  new Promise((resolve, reject) => {
    try {
      const database = store.getters['database/get']
      const request = database.transaction([collectionName], 'readonly').objectStore(collectionName).getAll()
      request.onsuccess = () => resolve(request.result)
      request.onerror = (event) => reject(event)
    } catch (error) {
      reject(error)
    }
  })

export const clearAllCollection = async () => {
  try {
    const current = new Date().getTime()
    for (const property in config) {
      try {
        const list = await findAll(property)
        if (list) {
          list.forEach(({ id, exp }) => {
            if (exp <= current) {
              deleteData(property, id)
            }
          })
        }
      } catch (err) {
        // eslint-disable-next-line no-console
        console.log(err)
      }
    }
  } catch (error) {
    // eslint-disable-next-line no-console
    console.log(error)
  }
}

export const searchData = (collectionName, id) =>
  new Promise((resolve, reject) => {
    try {
      const database = store.getters['database/get']
      const request = database.transaction([collectionName], 'readonly').objectStore(collectionName).get(id)
      request.onsuccess = async () => {
        const data = request.result
        if (data) {
          if (data.exp > new Date().getTime()) {
            return resolve(data)
          }
          await deleteData(collectionName, id)
        }
        return resolve(null)
      }
      request.onerror = (event) => reject(event)
    } catch (error) {
      reject(error)
    }
  })

export const saveData = (collectionName, data) =>
  new Promise((resolve, reject) => {
    const database = store.getters['database/get']
    if (!database) return reject('DB has not been initialized !')
    const objectStore = database.transaction([collectionName], 'readwrite').objectStore(collectionName)
    const exp = config[collectionName].exp || 60 * 60 * 24 * 1000
    const request = objectStore.add({ ...data, exp: exp + new Date().getTime() })
    request.onsuccess = function () {
      return resolve(data)
    }
    request.onerror = function (event) {
      return reject(event)
    }
  })

export const updateData = (collectionName, data) =>
  new Promise((resolve, reject) => {
    const database = store.getters['database/get']
    if (!database) return reject('db has not been initialized !')
    const objectStore = database.transaction([collectionName], 'readwrite').objectStore(collectionName)
    const exp = config[collectionName].exp || 60 * 60 * 24 * 1000
    const request = objectStore.put({ ...data, exp: exp + new Date().getTime() })
    request.onsuccess = function () {
      return resolve(data)
    }
    request.onerror = function (event) {
      return reject(event)
    }
  })

export const deleteData = (collectionName, id) =>
  new Promise((resolve, reject) => {
    const database = store.getters['database/get']
    if (!database) return reject('db has not been initialized !')
    const objectStore = database.transaction([collectionName], 'readwrite').objectStore(collectionName)
    const request = objectStore.delete(id)
    request.onsuccess = function () {
      return resolve(true)
    }
    request.onerror = function (event) {
      return reject(event)
    }
  })
