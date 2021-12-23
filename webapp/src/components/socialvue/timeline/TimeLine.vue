<template>
  <ul class="iq-timeline">
    <li v-for="(item, index) in items" :key="index">
      <div class="timeline-dots" :class="'border-' + item.color"></div>
      <h6 class="float-left mb-1">{{ item.title }}</h6>
      <small class="float-right mt-1">{{ item.right }}</small>
      <div class="d-inline-block w-100">
        <p>{{ item.description }}</p>
        <template v-if="item.child.items.length > 0 && item.child.type === 'img'">
          <div class="iq-media-group">
            <a v-for="(childItem, childIndex) in item.child.items" :key="childIndex" href="#" class="iq-media">
              <img :src="childItem" class="img-fluid avatar-40 rounded-circle" alt="img" />
            </a>
          </div>
        </template>
      </div>
    </li>
  </ul>
</template>

<script>
export default {
  name: 'TimeLine',
  props: {
    items: { type: Array, default: () => [] }
  }
}
</script>

<style lang="scss" scoped>
.iq-timeline {
  margin: 0 0 0 5px;
  padding: 0;
  width: 100%;
  border-left: 3px solid var(--white);
}
.iq-timeline li {
  margin-left: 15px;
  position: relative;
  padding: 15px 15px 0 5px;
  list-style-type: none;
}
.iq-timeline li .timeline-dots {
  position: absolute;
  top: 20px;
  left: -24px;
  border: 3px solid var(--gray-dark);
  border-radius: 90px;
  padding: 5px;
  background: var(--white);
}
</style>
