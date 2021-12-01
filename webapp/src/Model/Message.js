export default class Message {
  constructor(message = {}) {
    this.id = typeof message.id === 'number' ? message.id : 0
    this.text = typeof message.text === 'string' ? message.text : ''
    this.time = typeof message.time === 'string' ? message.time : ''
    this.userId = typeof message.userId === 'number' ? message.userId : ''
    this.me = typeof message.me === 'boolean' ? message.me : false
    this.created_at = typeof message.created_at === 'boolean' ? message.created_at : false
  }
}
