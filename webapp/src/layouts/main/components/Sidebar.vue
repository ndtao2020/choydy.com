<template>
  <div class="iq-sidebar">
    <div id="sidebar-scrollbar" class="mt-2">
      <nav class="iq-sidebar-menu">
        <b-collapse tag="ul" class="iq-menu" :visible="true">
          <template v-for="root in catalogs">
            <div :key="root.a0" class="d-flex menu-root my-2">
              <span class="mx-auto menu-root-text text-secondary">{{ root.a1 }}</span>
              <hr class="my-auto menu-root-break" />
            </div>
            <router-link
              v-for="catalog in root.children"
              :key="catalog.a0"
              v-slot="{ href, navigate, isActive, isExactActive }"
              :to="'/catalog/' + catalog.a0"
              custom
            >
              <li :class="[isActive && isExactActive && 'active']">
                <a :href="href" :class="[isActive && isExactActive && 'active']" @click="navigate">
                  <img :src="require(`@/assets/icons/smile/${catalog.a0 <= 50 ? catalog.a0 : 0}.svg`)" height="25" width="25" />
                  <span class="ml-2">{{ catalog.a1 }}</span>
                </a>
              </li>
            </router-link>
          </template>
        </b-collapse>
      </nav>
    </div>
  </div>
</template>

<script>
import { getCatalogs } from '@/api/catalog'
import { generateTreeFromArray } from '@/utils'

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
          this.catalogs = generateTreeFromArray(data, 0, 3)
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
  height: 100%;
  background: var(--white);
  max-width: 260px;
  transition: all 0.3s ease-in-out;
  box-shadow: 0px 0px 20px 0px rgba(44, 101, 144, 0.1);
}
</style>
