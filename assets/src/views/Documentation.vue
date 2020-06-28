<template>
  <div class="share-content-menu-documentation">
    <div class="doc-container">
      <!-- Отображение кнопок в левой части -->
      <div class="share-content-menu-documentation-wrapper">
        <div
          v-for="(item, index) of listItems"
          :key="index"
          class="share-content-menu-documentation-item"
          :class="{ active: item == activeItem }"
          @click.self="clickTitle({ item })"
        >
          {{ filteredDocs[item].title }}
        </div>
      </div>
      <!-- Отображение самой документации -->
      <div v-if="filteredDocs && filteredDocs[activeItem]" class="width_block">
        <div v-if="filteredDocs[activeItem].title">
          <!-- Документация модуля -->
          <vue-markdown
            :source="filteredDocs[activeItem].title"
            class="title"
            :postrender="hightligth_text"
          />
          <!-- Документация функций -->
          <div
            v-for="(doc, name, index) in filteredDocs[activeItem].parts"
            :key="index"
          >
            <hr />
            <strong>{{ doc.title }}</strong>
            <vue-markdown
              :source="doc.markdown"
              :postrender="hightligth_text"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import VueMarkdown from "vue-markdown";
// Лодаш используется для полного копирования исходного объекта
import _ from "lodash";

import goal from "!!raw-loader!../documentation/introduction/goal.md";
import benefits from "!!raw-loader!../documentation/introduction/benefits.md";
import code from "!!raw-loader!../documentation/usage/code.md";

export default {
  components: { VueMarkdown },
  props: {
    documentation: {
      // type: Object,
      default: function () {
        return {
          introduction: {
            title: "Введение",
            parts: [
              {
                title: "Предназначение сервиса",
                markdown: goal,
              },
              {
                title: "",
                markdown: benefits,
              },
            ],
          },
          connection: {
            title: "Подключение к ServiceGraph",
            parts: [
              {
                title: "",
                markdown: code,
              },
            ],
          },
          usage: {
            title: "Использование",
            parts: [
              {
                title: "",
                markdown: "В разработке",
              },
            ],
          },
          gitlab_ci: {
            title: "Настройка GitLab CI",
            parts: [
              {
                title: "",
                markdown: "В разработке",
              },
            ],
          },
        };
      },
    },
    items: {
      // type: Array,
      default: function () {
        return [];
      },
    },
  },
  data() {
    return {
      filterString: "",
      selectedItem: null,
    };
  },
  computed: {
    listItems() {
      return Object.keys(this.filteredDocs || {});
    },
    activeItem() {
      if (this.selectedItem) {
        if (this.listItems.indexOf(this.selectedItem) >= 0) {
          return this.selectedItem;
        } else {
          return this.listItems[0];
        }
      } else {
        // Если нет выбранного элемента, то пытаемся взять его из URL
        var module = this.$route.params.module;
        if (module && this.listItems.indexOf(module) >= 0) {
          return module;
        } else {
          return this.listItems[0];
        }
      }
    },
    filteredDocs() {
      return this.filterDocs(this.documentation || {}, this.filterString);
    },
  },
  watch: {
    filterString: {
      handler: function () {
        this.filteredDocs = this.filterDocs(
          this.documentation || {},
          this.filterString
        );
      },
    },
  },
  methods: {
    hightligth_text(markdown) {
      if (this.filterString === "") {
        return markdown;
      } else {
        var regex = new RegExp(this.filterString, "g");
        return markdown.replace(
          regex,
          '<strong class="hightlight">' + this.filterString + "</strong>"
        );
      }
    },
    clickTitle(item) {
      // Подменяем URL в браузере
      window.history.pushState({}, null, "/doc/" + item.item);
      this.$route.params.module = item.item;
      this.selectedItem = item.item;
    },
    filterDocs: function (documentation, filter) {
      filter;
      return _.cloneDeep(documentation);
    },
  },
};
</script>

<style lang="scss">
.width_block {
  max-width: 1000px;
  width: 800px;
  text-align: left;
  min-width: 640px;
  margin: 0px 5px 0px 10px;
  img {
    max-width: 640px;
  }
}
.share-content-menu-documentation {
  code {
    color: green;
    font: 14px;
  }
  pre {
    background-color: bisque;
    code.language-code {
      color: rgb(22, 19, 19);
    }
  }
  .top-filter {
    margin-bottom: 10px;
    .filter {
      width: 600px;
      height: 32px;
      border: solid 3px #42b983;
      border-radius: 3px;
    }
  }
  .doc-container {
    display: flex;
  }
  .share-content-menu-documentation-wrapper {
    position: relative;
    z-index: 1;
    width: 260px;
  }
  width: 100%;
  z-index: 1;
  height: auto !important;

  &-item {
    text-align: center;
    position: relative;
    width: 260px;
    background: #e0e0e0;
    color: #000;
    line-height: 60px;
    height: 60px;
    cursor: pointer;
    font-size: 14px;
    overflow: hidden;
    opacity: 1;
    &:hover {
      color: black;
      background: white;
    }
  }
  .share-content-menu-documentation-item {
    &.active {
      color: white;
      background: #6fb997;
    }
  }
  .title {
    background: #6fb997;
    font-size: 18px;
    color: white;
    padding: 10px;
  }
}
</style>
