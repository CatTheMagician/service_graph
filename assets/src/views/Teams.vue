<template>
  <div class="teams">
    <router-link to="/teams/new"><button>Создать</button></router-link>
    <ul v-for="team in teams" :key="team.title">
      <li>
        <router-link :to="elementPath(team.id)">{{ team.title }}</router-link>
      </li>
    </ul>
  </div>
</template>

<script>
import { teamsList } from "../repository/teams";

export default {
  name: "Teams",
  components: {},
  methods: {
    elementPath(id) {
      return this.$route.path + "/" + id;
    },
  },
  data() {
    return {
      teams: [],
    };
  },
  async mounted() {
    teamsList().then((response) => {
      this.teams = response.data;
    });
  },
};
</script>

<style lang="scss" scoped>
.teams {
  text-align: left;
}
li {
  text-align: left;
}
</style>
