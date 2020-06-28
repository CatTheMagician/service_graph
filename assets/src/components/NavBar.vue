<template>
  <div class="navbar">
    <router-link
      @click="clickTitle(item)"
      v-for="item in items"
      class="item"
      :class="{ active: item.href == active }"
      :to="item.href"
      :key="item.href"
    >
      {{ item.title }}
    </router-link>
    <!-- <Search /> -->
  </div>
</template>

<script>
// import Search from "./Search.vue";

export default {
  name: "NavBar",
  components: {
    // Search
  },
  props: {
    items: {
      type: Array,
      default: () => [],
    },
  },
  computed: {
    active() {
      var def = { href: "/main" };
      var el =
        this.items.find((element) => {
          return this.$route.path.indexOf(element.href) >= 0;
        }) || def;

      return el.href;
    },
  },
  methods: {
    clickTitle(item) {
      this.active = item.href;
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>
.navbar {
  z-index: 2;
  position: fixed;
  background-color: #23432b;
  padding: 5px 0 5px 5px;
  margin-top: -5px;
  width: 100%;
  height: 40px;
  border-left: 1px #ccc solid;
  flex: 1 1 100%;
}
.item {
  &a {
    background-color: inherit;
  }
  flex-grow: 1;
  // display: inline-block;
  float: left;
  text-align: center;
  margin: 4px 4px 4px 0px;
  height: 22px;
  font-size: 18px;
  max-width: 256px;
  padding: 10px 20px 10px 20px;
  text-decoration: none;
  color: white;
  background-color: #6fb997;
  &.active {
    background-color: white;
    color: black;
    cursor: default !important;
  }
  &:hover {
    background-color: white;
    color: black;
    cursor: pointer;
  }
  .right {
    float: right;
  }
}
</style>
