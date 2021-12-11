<template>
  <b-row>
    <b-col sm="12">
      <b-row class="m-0 p-0">
        <b-col lg="8">
          <div v-for="post in socialPosts" :key="post.id">
            <social-post :post="post"></social-post>
          </div>
        </b-col>
        <b-col lg="4">
          <iq-card>
            <template #headerTitle>
              <h4 class="card-title">Stories</h4>
            </template>
            <template #body>
              <ul class="media-story m-0 p-0">
                <li class="d-flex mb-4 align-items-center">
                  <i class="ri-add-line font-size-18"></i>
                  <div class="stories-data ml-3">
                    <h5>Creat Your Story</h5>
                    <p class="mb-0">time to story</p>
                  </div>
                </li>
                <li v-for="(item, index) in story" :key="index" class="d-flex align-items-center" :class="item.isActive + ' ' + item.class">
                  <b-img :src="item.image" alt="story-img" rounded="circle" fluid />
                  <div class="stories-data ml-3">
                    <h5>{{ item.title }}</h5>
                    <p class="mb-0">{{ item.time }}</p>
                  </div>
                </li>
              </ul>
              <b-link class="btn btn-primary d-block mt-3"><i class="ri-add-line"></i> See All</b-link>
            </template>
          </iq-card>
          <iq-card>
            <template #headerTitle>
              <h4 class="card-title">Events</h4>
            </template>
            <template #body>
              <ul class="media-story m-0 p-0">
                <li v-for="(eventR, index) in event" :key="index" class="d-flex mb-4 align-items-center">
                  <img :src="eventR.img" alt="story-img" class="rounded-circle img-fluid" />
                  <div class="stories-data ml-3">
                    <h5>{{ eventR.heading }}</h5>
                    <p class="mb-0">{{ eventR.time }}</p>
                  </div>
                </li>
              </ul>
            </template>
          </iq-card>
          <iq-card>
            <template #headerTitle>
              <h4 class="card-title">Upcomming Birthday</h4>
            </template>
            <template #body>
              <ul class="suggestions-lists m-0 p-0">
                <li v-for="(item, index) in suggestions" :key="index" class="d-flex mb-4 align-items-center">
                  <div class="user-img img-fluid">
                    <b-img :src="item.image" alt="story-img" rounded="circle" class="avatar-40" />
                  </div>
                  <div class="media-support-info ml-3">
                    <h6>{{ item.name }}</h6>
                    <p class="mb-0">{{ item.mutual_friend }}</p>
                  </div>
                </li>
              </ul>
            </template>
          </iq-card>
          <iq-card>
            <template #headerTitle>
              <h4 class="card-title">Suggested Pages</h4>
            </template>
            <template #body>
              <ul class="suggested-page-story m-0 p-0 list-inline">
                <li v-for="(post, index) in suggestionEvent" :key="index" class="mb-3">
                  <div class="d-flex align-items-center mb-3">
                    <img :src="post.img" alt="story-img" class="rounded-circle img-fluid avatar-50" />
                    <div class="stories-data ml-3">
                      <h5>{{ post.title }}</h5>
                      <p class="mb-0">{{ post.des }}</p>
                    </div>
                  </div>
                  <img :src="post.otherImg" class="img-fluid rounded" alt="Responsive image" />
                  <div class="mt-3">
                    <a href="#" class="btn d-block"><i class="ri-thumb-up-line mr-2"></i> Like Page</a>
                  </div>
                </li>
              </ul>
            </template>
          </iq-card>
        </b-col>
      </b-row>
    </b-col>
    <div class="col-sm-12 text-center">
      <img src="@/assets/images/page-img/page-load-loader.gif" alt="loader" style="height: 100px" width="75" height="100" />
    </div>
  </b-row>
</template>
<script>
import { Posts } from '@/FackApi/api/SocialPost'

export default {
  components: {
    SocialPost: () => import('./Components/SocialPost'),
    IqCard: () => import('@/components/socialvue/cards/iq-card')
  },
  data() {
    return {
      suggestionEvent: [
        {
          img: require('@/assets/images/page-img/42.png'),
          title: 'Iqonic Studio',
          des: 'Lorem Ipsum',
          otherImg: require('@/assets/images/small/img-1.jpg')
        },
        {
          img: require('@/assets/images/page-img/43.png'),
          title: 'Cakes & Bakes ',
          des: 'Lorem Ipsum',
          otherImg: require('@/assets/images/small/img-2.jpg')
        }
      ],
      event: [
        {
          img: require('@/assets/images/page-img/s4.jpg'),
          heading: 'Web Workshop',
          time: '1 hour ago'
        },
        {
          img: require('@/assets/images/page-img/s5.jpg'),
          heading: 'Fun Events and Festivals',
          time: '4 hour ago'
        }
      ],
      socialPosts: Posts,
      story: [
        { title: 'Web Design', time: '1 hour ago', image: require('@/assets/images/page-img/s1.jpg'), class: 'mb-4', isActive: 'active' },
        { title: 'App Design', time: '4 hour ago', image: require('@/assets/images/page-img/s2.jpg'), class: 'mb-4', isActive: '' },
        { title: 'Abstract Design', time: '9 hour ago', image: require('@/assets/images/page-img/s3.jpg'), class: '', isActive: '' }
      ],
      suggestions: [
        { name: 'Paul Molive', mutual_friend: 'Today', image: require('@/assets/images/user/user-01.jpg') },
        { name: 'Paul Molive', mutual_friend: 'Tomorrow', image: require('@/assets/images/user/user-01.jpg') }
      ],
      news: [
        { description: 'there is a meetup in your city on friday at 19:00.<a href="#">see details</a>' },
        { description: '20% off coupon on selected items at pharmaprix' }
      ]
    }
  },
  methods: {
    addPost(post) {
      this.socialPosts.unshift(post)
    }
  }
}
</script>
