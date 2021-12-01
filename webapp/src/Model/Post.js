export default class Post {
  constructor(post = {}) {
    this.id = typeof post.id === 'string' ? post.id : ''
    this.images = Array.isArray(post.images) ? post.images : []
    this.description = typeof post.description === 'string' ? post.description : ''
    this.likes = typeof post.likes === 'number' ? post.likes : 0
    this.time = typeof post.time === 'object' ? post.time : new Date()
    this.is_follow = typeof post.is_follow === 'boolean' ? post.is_follow : false
    this.is_liked = typeof post.is_liked === 'boolean' ? post.is_liked : false
    this.user = typeof post.user === 'object' ? post.user : { profile: require('../assets/images/page-img/g1.jpg'), name: 'Nik Jon' }
    this.comments = Array.isArray(post.comments) ? post.comments : []
  }
}
