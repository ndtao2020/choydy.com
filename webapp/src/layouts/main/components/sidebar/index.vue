<template>
  <div class="iq-sidebar">
    <div id="sidebar-scrollbar" class="mt-2">
      <nav class="iq-sidebar-menu">
        <b-collapse tag="ul" class="iq-menu" :visible="true">
          <router-link v-slot="{ href, navigate, isActive, isExactActive }" to="/" custom>
            <li :class="[isActive && isExactActive && 'active']">
              <a :href="href" :class="[isActive && isExactActive && 'active']" @click="navigate">
                <img src="@/assets/icons/news2.svg" height="25" width="25" />
                <span class="ml-2">{{ $t('sidebar.newsfeed') }}</span>
              </a>
            </li>
          </router-link>
          <hr />
          <b-card v-if="loading">
            <b-skeleton v-for="i in 15" :key="i" animation="fade" width="100%" class="mb-3" height="35px" />
          </b-card>
          <router-link v-for="catalog in catalogs" v-else :key="catalog[0]" v-slot="{ href, navigate, isActive, isExactActive }" to="/" custom>
            <li :class="[isActive && isExactActive && 'active']">
              <a :href="href" :class="[isActive && isExactActive && 'active']" @click="navigate">
                <img :src="require(`@/assets/icons/smile/${catalog[0] <= 15 ? catalog[0] : 0}.svg`)" height="25" width="25" />
                <span class="ml-2">{{ catalog[1] }}</span>
              </a>
            </li>
          </router-link>
        </b-collapse>
      </nav>
    </div>
  </div>
</template>

<script>
import { getCatalogs } from '@/api/catalog'

export default {
  name: 'MainSidebar',
  data() {
    return {
      loading: false,
      catalogs: []
    }
  },
  mounted() {
    this.loadCatalogs()
  },
  methods: {
    async loadCatalogs() {
      this.loading = true
      try {
        const data = await getCatalogs()
        if (data) {
          this.catalogs = data
        }
      } catch (error) {
        // eslint-disable-next-line no-console
        console.log(error)
      } finally {
        this.loading = false
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.iq-sidebar {
  position: fixed;
  z-index: 999;
  top: 75px;
  width: 250px;
  height: 100%;
  background: var(--white);
  transition: all 0.3s ease-in-out;
  box-shadow: 0px 0px 20px 0px rgba(44, 101, 144, 0.1);
}
</style>
