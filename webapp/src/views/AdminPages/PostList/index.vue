<template>
  <widget>
    <h1 class="page-title">Danh sách bài đã đăng</h1>
    <!-- Main table element -->
    <b-skeleton-table v-if="loading" :rows="10" :columns="4" :table-props="{ bordered: true, striped: true }" />
    <b-table v-else :items="items" :fields="fields" show-empty responsive>
      <template #cell(likes)="row"><Likes :id="row.item.id" /></template>
      <template #cell(userId)="row"><User :id="row.item.userId" /></template>
      <template #cell(created)="row">{{ formatTime(row.value) }}</template>
      <template #cell(actions)="row">
        <b-button size="sm" variant="success">
          <i class="las la-edit" />
        </b-button>
        <b-button size="sm" variant="warning" @click="row.toggleDetails">
          <i class="las la-eye" />
        </b-button>
        <b-button size="sm" variant="danger" @click="deletePost(row.item.id)">
          <i class="las la-trash" />
        </b-button>
      </template>
      <template #row-details="row">
        <social-post :post-id="row.item.id" />
      </template>
    </b-table>
    <b-row>
      <b-col sm="2" md="2" class="my-1">
        <b-skeleton v-if="loading" type="input" />
        <b-form-group
          v-else
          label="Per page"
          label-for="per-page-select"
          label-cols-sm="6"
          label-cols-md="4"
          label-cols-lg="3"
          label-align-sm="right"
          label-size="sm"
          class="mb-0"
        >
          <b-form-select id="per-page-select" v-model="perPage" :options="pageOptions" />
        </b-form-group>
      </b-col>
      <b-col>
        <b-skeleton v-if="loading" type="input" />
        <b-pagination v-else v-model="currentPage" :total-rows="totalRows" :per-page="perPage" align="fill" />
      </b-col>
    </b-row>
    <b-modal v-model="deleteModal" title="Bạn có muốn xóa bài đăng này ?">
      <p class="my-4">Hello from modal!</p>
    </b-modal>
  </widget>
</template>

<script>
import { dateDiff } from '@/moment'
import { postList, deletePost } from '@/api/admin/post'

export default {
  name: 'AdminPostList',
  components: {
    Widget: () => import('@/components/Widget'),
    Likes: () => import('./Likes'),
    User: () => import('./User'),
    SocialPost: () => import('../../Main/SocialPost')
  },
  data() {
    return {
      deleteModal: false,
      items: [],
      fields: [
        { key: 'id', label: 'Mã', sortable: true, sortDirection: 'desc' },
        { key: 'title', label: 'Tiêu đề', sortable: true, sortDirection: 'desc' },
        { key: 'count', label: 'Lượt xem', sortable: true, sortDirection: 'desc' },
        { key: 'likes', label: 'Lượt thích', sortable: true, sortDirection: 'desc' },
        { key: 'shares', label: 'Chia sẻ', sortable: true, sortDirection: 'desc' },
        { key: 'userId', label: '🧑', sortable: true, sortDirection: 'desc' },
        { key: 'created', label: '⏱️', sortable: true, sortDirection: 'desc' },
        { key: 'actions', label: '' }
      ],
      loading: false,
      totalRows: 1,
      currentPage: 1,
      perPage: 10,
      pageOptions: [10, 20, 30, 50, { value: 100, text: 'Show a lot' }],
      sortBy: '',
      sortDesc: false,
      sortDirection: 'asc',
      filter: null,
      filterOn: []
    }
  },
  watch: {
    perPage: function (val) {
      this.perPage = val
      this.loadData()
    },
    currentPage: function (val) {
      this.currentPage = val
      this.loadData()
    }
  },
  mounted() {
    // adsterra.com
    const adsterra = document.createElement('script')
    adsterra.setAttribute('type', 'text/javascript')
    adsterra.setAttribute('src', '//pl16933978.trustedcpmrevenue.com/00/12/2f/00122fa07403be8a174431b65f222f4c.js')
    document.body.appendChild(adsterra)
    // fetch
    this.loadData()
  },
  methods: {
    async loadData() {
      this.loading = true
      try {
        const data = await postList(this.currentPage - 1, this.perPage)
        if (data) {
          this.items = data.l
          this.totalRows = data.t
        }
      } catch (e) {
        // eslint-disable-next-line no-console
        console.log(e)
      } finally {
        this.loading = false
      }
    },
    formatTime(timestamp) {
      return dateDiff(timestamp)
    },
    async deletePost(id) {
      const confirm = await this.$bvModal.msgBoxConfirm(`Bạn đã thật sự muốn xóa bài này ?`, {
        title: 'Please Confirm',
        size: 'sm',
        buttonSize: 'sm',
        okVariant: 'danger',
        okTitle: 'YES',
        cancelTitle: 'NO',
        footerClass: 'p-2',
        hideHeaderClose: false,
        centered: true
      })
      if (!confirm) {
        return
      }
      this.loading = true
      try {
        await deletePost(id)
        await this.loadData()
      } catch (e) {
        // eslint-disable-next-line no-console
        console.log(e)
      } finally {
        this.loading = false
      }
    }
  }
}
</script>
