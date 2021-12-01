export default class User {
  constructor(user = {}) {
    this.id = typeof user.id === 'number' ? user.id : 0
    this.name = typeof user.name === 'string' ? user.name : ''
    this.image = typeof user.image === 'string' ? user.image : ''
    this.role = typeof user.role === 'string' ? user.role : ''
    this.about = typeof user.about === 'string' ? user.about : ''
    this.dob = typeof user.dob === 'string' ? user.dob : ''
    this.isActive = typeof user.isActive === 'boolean' ? user.isActive : false
    this.isPrivate = typeof user.isPrivate === 'boolean' ? user.isPrivate : false
  }
}
