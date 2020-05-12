defmodule ServiceGraphWeb.Api.TeamsView do
  use ServiceGraphWeb, :view

  alias ServiceGraph.Teams.Team

  def render("list.json", %{list: list}) do
    Enum.map(list, fn %Team{} = team ->
      %{
        id: team.id,
        title: team.title,
        color: team.color
      }
    end)
  end

  def render("show.json", %{team: %Team{} = team}) do
    %{
      id: team.id,
      title: team.title,
      color: team.color
    }
  end
end
