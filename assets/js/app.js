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

window.make_gray_all = function () {
  let map = window.network.canvas.body.nodes

  Object.keys(map).forEach(function (key, _i, ) {
    let el = map[key]

    el.options.color.original_background = el.options.color.original_background || el.options.color.background;
    el.options.color.background = 'WhiteSmoke';
  })

  window.network.redraw()
}

window.make_colored = function (name) {
  let map = window.network.canvas.body.nodes
  Object.keys(map).forEach(function (key, _i, ) {
    let el = map[key]

    if (el.options.shape != "box" && key.toUpperCase().includes(name.toUpperCase())) {
      el.options.color.background = el.options.color.original_background || el.options.color.background;
    }
  })

  window.network.redraw()
}

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
    $(input).on('input', function (e) {
      make_gray_all()
      make_colored(e.target.value)
    })
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

// инициализируем по необходимости блоки с json
Array.from(document.getElementsByClassName("nav_panel")).forEach(
  function (el, _i, _array) {
    let all = {
      color: 'gray',
      title: 'Все',
      services: nodes.map((e) => e.id)
    }
    let teams = [all].concat(JSON.parse(el.getAttribute("teams")))

    teams.forEach(function (team, _i, _array) {
      let button = document.createElement('div');
      button.setAttribute("class", "button with-margin")
      button.setAttribute("style", "background-color: " + team.color)
      button.innerHTML = team.title
      $(button).on('click', function () {
        make_gray_all()
        team.services.forEach((service, _i, _arr) => make_colored(service))
      })

      el.appendChild(button)
    })
  }
);