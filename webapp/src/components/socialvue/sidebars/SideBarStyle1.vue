<template>
  <div class="iq-sidebar">
    <div id="sidebar-scrollbar">
      <nav class="iq-sidebar-menu">
        <b-collapse tag="ul" class="iq-menu" :visible="true">
          <router-link v-for="(item, index) in items" :key="index" v-slot="{ href, navigate, isActive, isExactActive }" :to="item.link" custom>
            <li :class="[isActive && isExactActive && 'active']">
              <a :href="href" :class="['iq-waves-effect', isActive && isExactActive && 'active']" @click="navigate">
                <i v-if="item.is_icon_class" :class="item.icon" />
                <div v-else>{{ item.icon }}</div>
                <span>{{ $t(item.name) }}</span>
                <small :class="item.append_class">{{ item.append }}</small>
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
  props: {
    items: { type: Array },
    horizontal: { type: Boolean }
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
