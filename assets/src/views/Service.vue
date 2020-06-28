<template>
  <div class="service">
    <h3>{{ serviceInfo.title }}</h3>
    <hr />
    <button class="delete" @click="deleteService">Удалить</button>
  </div>
</template>

<script>
import { service, deleteService } from "../repository/services";

export default {
  name: "Service",
  components: {},
  methods: {
    deleteService() {
      deleteService(this.serviceTitle).then((response) => {
        if (response.data.result == "ok") {
          alert("Удалено");
        }
      });
    },
  },
  data() {
    return {
      serviceInfo: {},
    };
  },
  computed: {
    serviceTitle() {
      return this.$route.params.id;
    },
  },
  async mounted() {
    service(this.serviceTitle).then((response) => {
      this.serviceInfo = response.data;
    });
  },
};
</script>

<style>
.service {
  text-align: left;
}
.delete {
  background-color: rgb(247, 78, 66);
}
</style>
