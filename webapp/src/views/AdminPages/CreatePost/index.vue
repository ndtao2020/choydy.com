<template>
  <div class="dashboard-page">
    <h1 class="page-title">Tạo bài đăng</h1>
    <b-row>
      <b-col
        ><b-form @submit.prevent="handleSubmit">
          <b-form-group label="Tiêu đề">
            <b-form-input v-model="user.name" type="text" placeholder="Nhập tiêu đề"> </b-form-input>
          </b-form-group>
          <b-form-group label="Nội dung">
            <div class="wrapper">
              <textarea v-model="input" class="regular-input"></textarea>
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
                          <span v-for="(emoji, emojiName) in emojiGroup" :key="emojiName" :title="emojiName" @click="insert(emoji)">{{ emoji }}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </emoji-picker>
            </div>
          </b-form-group>
          <b-form-group label="Tags">
            <b-form-tags id="tags-with-dropdown" v-model="value" no-outer-focus class="mb-2">
              <template #default="{ tags, disabled, addTag, removeTag }">
                <ul v-if="tags.length > 0" class="list-inline d-inline-block mb-2">
                  <li v-for="tag in tags" :key="tag" class="list-inline-item">
                    <b-form-tag :title="tag" :disabled="disabled" variant="info" @remove="removeTag(tag)">{{ tag }}</b-form-tag>
                  </li>
                </ul>
                <b-dropdown size="sm" variant="outline-secondary" block menu-class="w-100">
                  <template #button-content> <b-icon icon="tag-fill"></b-icon>Chọn tag bất kì</template>
                  <b-dropdown-form @submit.stop.prevent="() => {}">
                    <b-form-group
                      label="Search tags"
                      label-for="tag-search-input"
                      label-cols-md="auto"
                      class="mb-0"
                      label-size="sm"
                      :description="searchDesc"
                      :disabled="disabled"
                    >
                      <b-form-input id="tag-search-input" v-model="search" type="search" size="sm" autocomplete="off"></b-form-input>
                    </b-form-group>
                  </b-dropdown-form>
                  <b-dropdown-divider></b-dropdown-divider>
                  <b-dropdown-item-button v-for="option in availableOptions" :key="option" @click="onOptionClick({ option, addTag })">
                    {{ option }}
                  </b-dropdown-item-button>
                  <b-dropdown-text v-if="availableOptions.length === 0"> There are no tags available to select </b-dropdown-text>
                </b-dropdown>
              </template>
            </b-form-tags>
          </b-form-group>
          <!-- <b-form-group label="City">
          <b-form-select v-model="user.city">
            <option value="">Choose</option>
            <option value="CA">Los Angeles</option>
            <option value="IL">Chicago</option>
            <option value="LA">New Orleans</option>
            <option value="NM">Santa Fe</option>
          </b-form-select>
        </b-form-group>
        <b-form-group label="Password">
          <b-form-input v-model="user.password" type="password" placeholder="Enter password"> </b-form-input>
        </b-form-group>
        <b-form-group label="Confirm Password">
          <b-form-input v-model="user.confirmation" type="password"></b-form-input>
        </b-form-group>
        <b-form-group>
          <b-form-checkbox-group v-model="user.hobbies">
            <b-form-checkbox value="Reading">Reading</b-form-checkbox>
            <b-form-checkbox value="Gyming">Gyming</b-form-checkbox>
            <b-form-checkbox value="Movies">Movies</b-form-checkbox>
          </b-form-checkbox-group>
        </b-form-group> -->
          <b-button block type="submit" variant="primary">Submit</b-button>
        </b-form></b-col
      >
      <b-col>2 of 3</b-col>
    </b-row>
    <div></div>
  </div>
</template>

<script>
export default {
  name: 'AdminCreatePost',
  components: {
    EmojiPicker: () => import('vue-emoji-picker')
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
      }
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
      this.input += emoji
    },
    handleSubmit() {
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
  max-width: 500px;
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
