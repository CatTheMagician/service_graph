import Vue from "vue";
import VueRouter from "vue-router";
import App from "./App.vue";

import Main from "./views/Main";
import Services from "./views/Services";
import Service from "./views/Service";
import Teams from "./views/Teams";
import Team from "./views/Team";
import NewTeam from "./views/NewTeam";
import Documentation from "./views/Documentation";

Vue.use(VueRouter);

Vue.config.productionTip = false;

const routes = [
  { path: "/teams", component: Teams },
  { path: "/teams/new", component: NewTeam },
  { path: "/teams/:id", component: Team },
  { path: "/services", component: Services },
  { path: "/services/:id", component: Service },
  { path: "/doc/:module", component: Documentation },
  { path: "/doc", component: Documentation },
  { path: "*", component: Main },
];

const router = new VueRouter({
  mode: "history",
  routes: routes,
});

new Vue({
  el: "#app",
  router: router,
  render: (h) => h(App),
});
