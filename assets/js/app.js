// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"
import "phoenix_html"
import $ from 'jquery';

window.jQuery = $;
window.$ = $;

// Используется для снятия отметок с группы чекбоксов
window.deselect_all = function (group_name) {
  Array.from(document.getElementsByClassName(group_name)).forEach(
    function (el, _i, _array) {
      el.checked = false;
    }
  )
}

// Используется для проставления отметок на группу чекбоксов
window.select_all = function (group_name) {
  Array.from(document.getElementsByClassName(group_name)).forEach(
    function (el, _i, _array) {
      el.checked = true;
    }
  )
}

var container = document.getElementById('service_network');
var nodes = new vis.DataSet(JSON.parse(container.getAttribute("nodes")))
var edges = new vis.DataSet(JSON.parse(container.getAttribute("edges")))

var data = {
  nodes: nodes,
  edges: edges
};

var options = {};
var network = new vis.Network(container, data, options);

window.data = data;
window.network = network;

window.make_gray_all_except = function (name) {
  let map = window.network.canvas.body.nodes

  Object.keys(map).forEach(function (key, _i, ) {
    let el = map[key]

    if (el.options.shape != "box" && key.toUpperCase().includes(name.toUpperCase())) {
      el.options.color.background = el.options.color.original_background || el.options.color.background;
    } else {
      el.options.color.original_background = el.options.color.original_background || el.options.color.background;
      el.options.color.background = 'WhiteSmoke';
    }
  })
  window.network.redraw()
}

// инициализируем по необходимости блоки с json
Array.from(document.getElementsByClassName("search_panel")).forEach(
  function (el, _i, _array) {
    let nodes = JSON.parse(el.getAttribute("nodes"))
    let input = document.createElement('input');
    input.setAttribute("class", "input_field")
    let ul = document.createElement('ul');
    $(input).on('input', (e) => make_gray_all_except(e.target.value))
    el.appendChild(input)
    el.appendChild(ul)

    nodes.forEach(function (el, _i, _array) {
      if (el.shape != "box") {
        let li = document.createElement('li');
        li.innerHTML = el.id
        ul.appendChild(li)
      }
    })
  }
);
