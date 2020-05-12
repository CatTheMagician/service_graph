defmodule ServiceGraphWeb.Api.RelationController do
  use ServiceGraphWeb, :controller

  alias ServiceGraph.UseCases.RelationBulkUpdate
  alias ServiceGraph.UseCases.GraphVis

  def bulk_definition(conn, %{"Definitions" => definitions, "service_name" => service} = params) do
    RelationBulkUpdate.call(service, definitions, params["Gitstats"])

    resp(conn, 200, "OK")
  end

  def graph(conn, _params) do
    %{teams: teams, nodes: nodes, edges: edges} = GraphVis.call()

    render(conn, "graph.json", teams: teams, nodes: nodes, edges: edges)
  end
end
