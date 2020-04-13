// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"
import "phoenix_html"

var container = document.getElementById('service_network');
var nodes = new vis.DataSet(JSON.parse(container.getAttribute("nodes")))
var edges = new vis.DataSet(JSON.parse(container.getAttribute("edges")))

var data = {
  nodes: nodes,
  edges: edges
};

var options = {};
var network = new vis.Network(container, data, options);