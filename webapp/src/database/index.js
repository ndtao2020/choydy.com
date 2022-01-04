import store from '@/store'
import config from './base/config'

export const openConnection = () =>
  new Promise((resolve, reject) => {
    if (typeof window === 'undefined') {
      return
    }
    if (!('indexedDB' in window)) {
      reject("This browser doesn't support IndexedDB")
    }
    const request = window.indexedDB.open('d39zbi81v', 2)
    request.onupgradeneeded = (event) => {
      const db = event.target.result
      switch (event.oldVersion) {
        case 0: // no db created before
        case 1:
          for (const property in config) {
            const obj = config[property]
            db.createObjectStore(obj.name, obj.options)
          }
          break
        case 2:
          for (const property in config) {
            const obj = config[property]
            db.createObjectStore(obj.name, obj.options)
          }
          break
      }
    }
    request.onsuccess = (event) => resolve(event.target.result)
    request.onerror = () => reject(request.error)
  })

export const findAll = (collectionName) =>
  new Promise((resolve, reject) => {
    try {
      const database = store.getters['database/get']
      const request = database.transaction([collectionName]).objectStore(collectionName).getAll()
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
      const obj = config[property]
      const list = await findAll(obj.name)
      if (list) {
        list.forEach(async ({ id, exp }) => {
          if (exp < current) {
            await deleteData(obj.name, id)
            // eslint-disable-next-line no-console
            console.log('Deleted: ', obj.name, id)
          }
        })
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
      const request = database.transaction([collectionName]).objectStore(collectionName).get(id)
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

export const saveData = (collectionName, exp, data) =>
  new Promise((resolve, reject) => {
    const database = store.getters['database/get']
    if (!database) return reject('DB has not been initialized !')
    const objectStore = database.transaction([collectionName], 'readwrite').objectStore(collectionName)
    const request = objectStore.add({ ...data, exp: exp + new Date().getTime() })
    request.onsuccess = function () {
      return resolve(data)
    }
    request.onerror = function (event) {
      return reject(event)
    }
  })

export const updateData = (collectionName, exp, data) =>
  new Promise((resolve, reject) => {
    const database = store.getters['database/get']
    if (!database) return reject('db has not been initialized !')
    const objectStore = database.transaction([collectionName], 'readwrite').objectStore(collectionName)
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
