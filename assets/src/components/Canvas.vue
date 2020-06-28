<template>
  <div class="badges">
    <div
      class="team-badge"
      v-for="team in teams"
      :key="team.title"
      :style="{ backgroundColor: team.color }"
      @click="makeGrayAllExceptTeam(team)"
    >
      {{ team.title }}
    </div>
    <div id="service_network" class="canvas">
      Загрузка....или Canvas не поддерживается
    </div>
  </div>
</template>

<script>
import { Network, DataSet } from "visjs-network";
import { graph } from "../repository/graph";

export default {
  name: "Canvas",
  data() {
    return {
      teams: null,
      nodes: null,
      edges: null,
      network: null,
    };
  },
  mounted() {
    graph().then((response) => {
      let graph_data = null;
      graph_data = response.data;

      this.teams = graph_data.teams;
      var data = {
        nodes: new DataSet(graph_data.nodes),
        edges: new DataSet(graph_data.edges),
      };
      this.network = new Network(
        document.getElementById("service_network"),
        data,
        {}
      );
    });
  },
  methods: {
    makeGrayAll() {
      let map = this.network.canvas.body.nodes;

      Object.keys(map).forEach(function (key) {
        let el = map[key];

        el.options.color.original_background =
          el.options.color.original_background || el.options.color.background;
        el.options.color.background = "WhiteSmoke";
      });

      this.network.redraw();
    },
    makeGrayAllExceptTeam(team) {
      this.makeGrayAll();
      team.services.forEach((service) => this.makeColored(service));
      this.network.redraw();
    },
    makeColored(name) {
      let map = this.network.canvas.body.nodes;
      Object.keys(map).forEach(function (key) {
        let el = map[key];

        if (
          el.options.shape != "box" &&
          key.toUpperCase().includes(name.toUpperCase())
        ) {
          el.options.color.background =
            el.options.color.original_background || el.options.color.background;
        }
      });
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>
.canvas {
  margin: 0;
  z-index: 1 !important;
  position: absolute;
  border-left: 1px #ccc solid;
  width: 100vw;
  height: 100vh;
  background-color: white;
}
.vis-network {
  z-index: 2;
}
.badges {
  position: absolute;
}
.team-badge {
  display: inline;
  color: white;
  font-weight: bold;
  text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
  padding: 10px;
  z-index: 4;
  border-radius: 4px;
  cursor: pointer;
  position: relative;
  top: 40px;
  margin: 10px;
  border: 1px solid #23432b;
}
</style>
