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
    const request = window.indexedDB.open('d39zbi81v')
    request.onupgradeneeded = (event) => {
      const db = event.target.result
      for (const property in config) {
        const obj = config[property]
        db.createObjectStore(obj.name, obj.options)
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
