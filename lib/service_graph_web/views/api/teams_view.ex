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

  def render("team_page.json", %{services: services, team: %Team{} = team}) do
    %{
      id: team.id,
      title: team.title,
      color: team.color,
      team_services: team.services,
      all_services: Enum.map(services, fn s -> s.title end)
    }
  end
end
