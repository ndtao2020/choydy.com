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
            <h4 slot="title" class="card-title">Youtube</h4>
            <template #body>
              <ul class="media-story m-0 p-0">
                <li class="d-flex align-items-center active mb-4">
                  <img src="@/assets/images/facebook/unnamed.jpg" alt="story-img" width="60" height="60" />
                  <div class="stories-data ml-3">
                    <h5>Nóng</h5>
                    <p class="mb-0">962 Người đăng ký</p>
                  </div>
                </li>
              </ul>
              <b-link class="btn btn-danger d-block mt-3" href="https://www.youtube.com/channel/UC4uxhittpSxavMAKP0-M4CQ" target="_blank">
                Xem chi tiết
              </b-link>
            </template>
          </iq-card>
          <iq-card>
            <h4 slot="title" class="card-title">Facebook</h4>
            <template #body>
              <ul class="suggested-page-story m-0 p-0 list-inline">
                <li class="mb-3">
                  <div class="d-flex align-items-center mb-3" style="cursor: pointer" @click="openLink">
                    <img
                      src="@/assets/images/facebook/avatar.jpg"
                      alt="story-img"
                      class="rounded-circle img-fluid avatar-50"
                      width="50"
                      height="50"
                    />
                    <div class="stories-data ml-3">
                      <h5>Dyn Kye</h5>
                      <p class="mb-0">377 Người theo dõi</p>
                    </div>
                  </div>
                  <img src="@/assets/images/facebook/poster.jpg" class="img-fluid rounded" alt="Responsive image" width="260" height="400" />
                </li>
              </ul>
            </template>
          </iq-card>
        </b-col>
      </b-row>
    </b-col>
    <div class="col-sm-12 text-center">
      <img src="@/assets/images/page-img/page-load-loader.gif" alt="loader" width="75" height="100" />
    </div>
  </b-row>
</template>

<script>
import { Posts } from '@/FackApi/api/SocialPost'

export default {
  name: 'HomePage',
  components: {
    IqCard: () => import('./IqCard'),
    SocialPost: () => import('./SocialPost')
  },
  data() {
    return {
      socialPosts: Posts
    }
  },
  methods: {
    openLink() {
      window.open('https://www.facebook.com/profile.php?id=100069109730056', '_blank')
    }
  }
}
</script>
