defmodule ServiceGraphWeb.PageController do
  use ServiceGraphWeb, :controller

  alias ServiceGraph.UseCases.GraphVis

  def index(conn, _params) do
    %{teams: teams, nodes: nodes, edges: edges} = GraphVis.call()
    render(conn, "index.html", teams: teams, nodes: nodes, edges: edges)
  end
end
