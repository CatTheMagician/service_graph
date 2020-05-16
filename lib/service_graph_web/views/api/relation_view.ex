defmodule ServiceGraphWeb.Api.RelationView do
  use ServiceGraphWeb, :view

  def render("graph.json", %{teams: teams, nodes: nodes, edges: edges}) do
    %{
      nodes: nodes,
      teams: teams,
      edges: edges
    }
  end
end
