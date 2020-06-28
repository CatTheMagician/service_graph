<template>
  <div id="services">
    <div class="card" v-for="char in alphabets" :key="char">
      <h5>{{ char }}</h5>
      <ul v-for="service in services" :key="service">
        <li v-if="service.toUpperCase().startsWith(char)">
          <router-link :to="elementPath(service)">{{ service }}</router-link>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import { servicesList } from "../repository/services";

export default {
  name: "Services",
  components: {},
  methods: {
    elementPath(id) {
      return this.$route.path + "/" + id;
    },
  },
  data() {
    return {
      services: [],
    };
  },
  async mounted() {
    servicesList().then((response) => {
      this.services = response.data;
    });
  },
  computed: {
    alphabets() {
      var services = this.services || new Array();

      var alphabets = services.map((e) => e && e[0].toUpperCase());

      var unique = [...new Set(alphabets)];

      return unique;
    },
  },
};
</script>

<style lang="scss" scoped>
.card {
  width: 200px;
  h5 {
    width: 500px;
    border-bottom: 1px solid black;
    margin: 15px;
  }
  li {
    text-align: left;
  }
}
</style>
