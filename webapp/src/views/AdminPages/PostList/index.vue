<template>
  <widget>
    <h1 class="page-title">Danh sách bài đã đăng</h1>
    <!-- Main table element -->
    <b-skeleton-table v-if="loading" :rows="10" :columns="4" :table-props="{ bordered: true, striped: true }" />
    <b-table
      v-else
      :items="items"
      :fields="fields"
      :current-page="currentPage"
      :per-page="perPage"
      :filter="filter"
      :filter-included-fields="filterOn"
      :sort-by.sync="sortBy"
      :sort-desc.sync="sortDesc"
      :sort-direction="sortDirection"
      stacked="md"
      show-empty
      @filtered="onFiltered"
    >
      <template #cell(tags)="row"><Tag :id="row.item.id" :tags="row.value" /></template>
      <template #cell(media)="row"><Media :id="row.item.id" :media="row.value" /></template>
      <template #cell(userId)="row"><User :id="row.value" /></template>
      <template #cell(created)="row">{{ formatTime(row.value) }}</template>
      <template #cell(actions)="row">
        <b-button size="sm" variant="danger" @click="row.toggleDetails">Xóa</b-button>
      </template>
      <template #row-details="row">
        <b-card>
          <ul>
            <li v-for="(value, key) in row.item" :key="key">{{ key }}: {{ value }}</li>
          </ul>
        </b-card>
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
          <b-form-select id="per-page-select" v-model="perPage" :options="pageOptions" size="sm" />
        </b-form-group>
      </b-col>
      <b-col>
        <b-skeleton v-if="loading" type="input" />
        <b-pagination-nav v-else v-model="currentPage" :total-rows="totalRows" :per-page="perPage" />
      </b-col>
    </b-row>
  </widget>
</template>

<script>
import moment from 'moment'
import { postList } from '@/api/admin/post'

export default {
  name: 'AdminPostList',
  components: {
    Widget: () => import('@/components/Widget'),
    Tag: () => import('./Tag'),
    Media: () => import('./Media'),
    User: () => import('./User')
  },
  data() {
    return {
      items: [],
      fields: [
        { key: 'title', label: 'Tiêu đề', sortable: true, sortDirection: 'desc' },
        { key: 'content', label: 'Nội dung', sortable: true, sortDirection: 'desc' },
        { key: 'tags', label: 'Tag', sortable: true, sortDirection: 'desc' },
        { key: 'media', label: 'Media', sortable: true, sortDirection: 'desc' },
        { key: 'likes', label: 'Số lượt thích', sortable: true, sortDirection: 'desc' },
        { key: 'shares', label: 'Số lượt chia sẻ', sortable: true, sortDirection: 'desc' },
        { key: 'userId', label: 'Người đăng', sortable: true, sortDirection: 'desc' },
        { key: 'created', label: 'Thời gian', sortable: true, sortDirection: 'desc' },
        { key: 'actions', label: 'Actions' }
      ],
      loading: false,
      totalRows: 1,
      currentPage: 1,
      perPage: 20,
      pageOptions: [20, 30, 50, { value: 100, text: 'Show a lot' }],
      sortBy: '',
      sortDesc: false,
      sortDirection: 'asc',
      filter: null,
      filterOn: []
    }
  },
  mounted() {
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
      return moment(timestamp).format('DD/MM/YYYY - hh:mm:ss')
    }
  }
}
</script>
