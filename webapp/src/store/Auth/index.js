import Cookies from 'js-cookie'

const checkLogged = () => {
  const session = localStorage.getItem('session')
  const expires = localStorage.getItem('expires_in')
  return Cookies.get('_id') != null && session != null && expires != null
}

export default {
  namespaced: true,
  state: {
    logged: checkLogged()
  },
  getters: {
    logged: ({ logged }) => logged
  }
}
