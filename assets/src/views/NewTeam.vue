<template>
  <div class="team">
    <div class="field">
      <label>Название</label>
      <input type="text" v-model="team.title" />
    </div>
    <div class="field">
      <label>Цвет</label>
      <compact :value="colors" @input="updateColor" />
    </div>
    <div class="field">
      <label>Сервисы</label>
      <div v-for="service in team.all_services" :key="service">
        <input
          type="checkbox"
          :id="service"
          @change="toggleService(service)"
          :checked="hasService(service)"
        />
        <label>{{ service }}</label>
      </div>
    </div>
    <div class="field">
      <button class="button update" @click="createTeam">Сохранить</button>
    </div>
  </div>
</template>

<script>
import { createTeam } from "../repository/teams";
import { servicesList } from "../repository/services";
import { Compact } from "vue-color";
export default {
  name: "NewTeam",
  components: { Compact },
  data() {
    return {
      team: {
        title: "",
        color: "#fff",
        team_services: [],
        all_services: [],
      },
    };
  },
  methods: {
    hasService(service) {
      return this.team.team_services.indexOf(service) >= 0;
    },
    toggleService(service) {
      if (this.hasService(service)) {
        var services = this.team.team_services;
        this.team.team_services = services.filter((e) => e != service);
      } else {
        this.team.team_services.push(service);
      }
    },
    updateColor(color) {
      this.team.color = color.hex;
    },
    async createTeam() {
      createTeam(
        this.teamID,
        this.team.title,
        this.team.color,
        this.team.team_services
      ).then((response) => {
        this.team = response.data;
        alert("Обновлено");
      });
    },
  },
  computed: {
    colors() {
      return { hex: this.team.color };
    },
  },
  async mounted() {
    servicesList().then((response) => {
      this.team.all_services = response.data;
    });
  },
};
</script>

<style lang="scss" scoped>
.team {
  text-align: left;
  .field {
    width: 240px;
    margin: 35px;
  }
  label {
    text-decoration: underline;
  }
  input[type="text"] {
    width: 240px;
    height: 32px;
  }
  input[type="checkbox"] {
    margin-right: 10px;
  }
  .update {
    color: black;
    background-color: #f0c63b;
  }
}
</style>
