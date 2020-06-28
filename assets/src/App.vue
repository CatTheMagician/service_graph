<template>
  <div id="app">
    <NavBar v-bind:items="links" />
    <router-view class="content" />
  </div>
</template>

<script>
import NavBar from "./components/NavBar.vue";

export default {
  name: "App",
  data() {
    return {
      links: [
        { href: "/main", title: "Главная" },
        { href: "/teams", title: "Команды" },
        { href: "/services", title: "Сервисы" },
        { href: "/doc", title: "Документация" },
      ],
    };
  },
  components: {
    NavBar,
  },
};
</script>

<style>
.button {
  height: 32px;
  width: 120px;
  color: white;
  font-size: 18px;
  cursor: pointer;
  background-color: #6fb997;
}
button {
  cursor: pointer;
  height: 32px;
  width: 120px;
  color: white;
  font-size: 18px;
  background-color: #6fb997;
}
#app {
  text-align: center;
  color: #2c3e50;
  flex-flow: row column;
  display: flex;
}
a {
  color: #23432b;
}
.content {
  margin-top: 50px;
  z-index: 1;
  position: absolute;
  width: 100vw;
  height: 100vh;
  background-color: white;
}
html,
body {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  height: 100vh;
  width: 100vw;
}
</style>
