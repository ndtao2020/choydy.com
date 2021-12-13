<template>
  <div class="iq-sidebar">
    <div id="sidebar-scrollbar">
      <nav class="iq-sidebar-menu">
        <b-collapse tag="ul" class="iq-menu" :visible="true">
          <router-link v-slot="{ href, navigate, isActive, isExactActive }" to="/" custom>
            <li :class="[isActive && isExactActive && 'active']">
              <a :href="href" :class="[isActive && isExactActive && 'active']" @click="navigate">
                <img src="@/assets/icons/news.svg" height="25" width="25" />
                <span class="ml-2">{{ $t('sidebar.newsfeed') }}</span>
              </a>
            </li>
          </router-link>
        </b-collapse>
      </nav>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MainSidebar'
}
</script>

<style lang="scss" scoped>
.iq-sidebar {
  position: fixed;
  z-index: 999;
  top: 75px;
  width: 250px;
  height: 100%;
  background: var(--iq-white);
  transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out;
  box-shadow: 0px 0px 20px 0px rgba(44, 101, 144, 0.1);
}
.iq-sidebar .iq-sidebar-logo {
  float: none;
  width: 100%;
}
.iq-sidebar #sidebar-scrollbar {
  margin-top: 15px;
}
</style>
