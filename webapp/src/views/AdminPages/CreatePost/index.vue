<template>
  <div class="dashboard-page">
    <h1 class="page-title">Tạo bài đăng</h1>
    <b-row>
      <b-col col lg="5" md="5">
        <widget>
          <h4 class="text-center mb-1">Nhập thông tin bài đăng</h4>
          <b-form @submit.prevent="handleSubmit">
            <b-form-group label="Tiêu đề">
              <b-form-input v-model="post.title" type="text" placeholder="Nhập tiêu đề"> </b-form-input>
            </b-form-group>
            <b-form-group label="Nội dung">
              <div class="wrapper">
                <textarea v-model="post.description" class="regular-input"></textarea>
                <emoji-picker :search="search" @emoji="append">
                  <div slot="emoji-invoker" slot-scope="{ events: { click: clickEvent } }" class="emoji-invoker" @click.stop="clickEvent">
                    <svg height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg">
                      <path d="M0 0h24v24H0z" fill="none" />
                      <path
                        d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm3.5-9c.83 0 1.5-.67 1.5-1.5S16.33 8 15.5 8 14 8.67 14 9.5s.67 1.5 1.5 1.5zm-7 0c.83 0 1.5-.67 1.5-1.5S9.33 8 8.5 8 7 8.67 7 9.5 7.67 11 8.5 11zm3.5 6.5c2.33 0 4.31-1.46 5.11-3.5H6.89c.8 2.04 2.78 3.5 5.11 3.5z"
                      />
                    </svg>
                  </div>
                  <div slot="emoji-picker" slot-scope="{ emojis, insert, display }">
                    <div class="emoji-picker" :style="{ top: display.y + 'px', left: display.x + 'px' }">
                      <div class="emoji-picker__search">
                        <input v-model="search" v-focus type="text" />
                      </div>
                      <div>
                        <div v-for="(emojiGroup, category) in emojis" :key="category">
                          <h5>{{ category }}</h5>
                          <div class="emojis">
                            <span v-for="(emoji, emojiName) in emojiGroup" :key="emojiName" :title="emojiName" @click="insert(emoji)">{{
                              emoji
                            }}</span>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </emoji-picker>
              </div>
            </b-form-group>
            <b-form-group label="Tags">
              <b-form-tags v-model="post.tags" placeholder="Nhập từ khóa" tag-variant="primary" :tag-validator="tagValidator">
                <template #invalid-feedback> You must provide at least 3 tags and no more than 8 </template>
                <template #description>
                  <div id="tags-validation-help">
                    Thẻ phải có độ dài từ 3 đến 5 ký tự và tất cả đều là chữ thường. Nhập các thẻ được phân tách bằng dấu cách hoặc nhấn enter.
                  </div>
                </template>
              </b-form-tags>
            </b-form-group>
            <b-form-group label="Đăng hình ảnh hoặc video">
              <b-tabs v-model="tabIndex" content-class="mt-3">
                <b-tab title="Nếu đăng hình ảnh" active>
                  <b-form-file v-model="postImage" :state="Boolean(postImage)" accept="image/jpeg,image/png,image/gif" @change="changeImage">
                    <template slot="file-name" slot-scope="{ names }">
                      <b-badge variant="dark">{{ names[0] }}</b-badge>
                      <b-badge v-if="names.length > 1" variant="dark" class="ml-1"> + {{ names.length - 1 }} More files </b-badge>
                    </template>
                  </b-form-file>
                </b-tab>
                <b-tab title="Nếu đăng video sex">
                  <b-form-file v-model="postImage" :state="Boolean(postImage)" accept="video/mp4,video/webm,video/x-flv" @change="changeVideo">
                    <template slot="file-name" slot-scope="{ names }">
                      <b-badge variant="dark">{{ names[0] }}</b-badge>
                      <b-badge v-if="names.length > 1" variant="dark" class="ml-1"> + {{ names.length - 1 }} More files </b-badge>
                    </template>
                  </b-form-file>
                </b-tab>
              </b-tabs>
            </b-form-group>
            <b-button block type="submit" variant="primary">Đăng bài</b-button>
          </b-form>
        </widget>
      </b-col>
      <b-col>
        <widget>
          <h4 class="text-center mb-1">Xem trước bài đăng</h4>
          <Preview :post="post" :tab="tabIndex" :image="urlImage" :video="urlVideo" />
        </widget>
      </b-col>
    </b-row>
    <div></div>
  </div>
</template>

<script>
export default {
  name: 'AdminCreatePost',
  components: {
    Widget: () => import('@/components/Widget'),
    EmojiPicker: () => import('vue-emoji-picker'),
    Preview: () => import('./Preview')
  },
  directives: {
    focus: {
      inserted(el) {
        el.focus()
      }
    }
  },
  data() {
    return {
      options: ['Apple', 'Orange', 'Banana', 'Lime', 'Peach', 'Chocolate', 'Strawberry'],
      input: '',
      search: '',
      value: [],
      user: {
        name: '',
        email: '',
        mobile: '',
        city: '',
        password: '',
        confirmation: '',
        hobbies: []
      },
      tabIndex: 0,
      post: {
        title: '',
        description: '',
        tags: []
      },
      urlImage: null,
      postImage: null,
      urlVideo: null,
      postVideo: null
    }
  },
  computed: {
    criteria() {
      // Compute the search criteria
      return this.search.trim().toLowerCase()
    },
    availableOptions() {
      const criteria = this.criteria
      // Filter out already selected options
      const options = this.options.filter((opt) => this.value.indexOf(opt) === -1)
      if (criteria) {
        // Show only options that match criteria
        return options.filter((opt) => opt.toLowerCase().indexOf(criteria) > -1)
      }
      // Show all options available
      return options
    },
    searchDesc() {
      if (this.criteria && this.availableOptions.length === 0) {
        return 'There are no tags matching your search criteria'
      }
      return ''
    }
  },
  methods: {
    append(emoji) {
      this.post.description += emoji
    },
    changeImage(e) {
      this.postImage = e.target.files[0]
      console.log(this.postImage)
      this.urlImage = URL.createObjectURL(this.postImage)
    },
    changeVideo(e) {
      this.postVideo = e.target.files[0]
      this.urlVideo = URL.createObjectURL(this.postVideo)
    },
    tagValidator(tag) {
      // Individual tag validator function
      return tag.length > 2 && tag.length < 100
    },
    handleSubmit() {
      if (!confirm('Bạn đã thật sự muốn đăng bài ?')) {
        return
      }
      if (!confirm('Bạn có hối hận gì không ?')) {
        return
      }
      console.log(this.user)
    },
    onOptionClick({ option, addTag }) {
      addTag(option)
      this.search = ''
    }
  }
}
</script>

<style lang="scss" scoped>
form {
  margin: 0 auto;
  text-align: left;
}
.col-form-label {
  font-weight: 600;
}
/* Tailwind CSS-styled demo is available here: https://codepen.io/DCzajkowski/pen/Brxvzj */
.wrapper {
  width: 100%;
  position: relative;
  display: inline-block;
}
.regular-input {
  padding: 0.5rem 1rem;
  border-radius: 3px;
  border: 1px solid #ccc;
  width: inherit;
  height: 12rem;
  outline: none;
}
.regular-input:focus {
  box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.5);
}
.emoji-invoker {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
  width: 1.5rem;
  height: 1.5rem;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.2s;
}
.emoji-invoker:hover {
  transform: scale(1.1);
}
.emoji-invoker > svg {
  fill: #b1c6d0;
}
.emoji-picker {
  position: fixed;
  z-index: 10;
  border: 1px solid #ccc;
  width: 15rem;
  height: 20rem;
  overflow: scroll;
  padding: 1rem;
  box-sizing: border-box;
  border-radius: 0.5rem;
  background: #fff;
  box-shadow: 1px 1px 8px #c7dbe6;
}
.emoji-picker__search {
  display: flex;
}
.emoji-picker__search > input {
  flex: 1;
  border-radius: 10rem;
  border: 1px solid #ccc;
  padding: 0.5rem 1rem;
  outline: none;
}
.emoji-picker h5 {
  margin-bottom: 0;
  color: #b1b1b1;
  text-transform: uppercase;
  font-size: 0.8rem;
  cursor: default;
}
.emoji-picker .emojis {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
.emoji-picker .emojis:after {
  content: '';
  flex: auto;
}
.emoji-picker .emojis span {
  padding: 0.2rem;
  cursor: pointer;
  border-radius: 5px;
}
.emoji-picker .emojis span:hover {
  background: #ececec;
  cursor: pointer;
}
</style>