defmodule ServiceGraphWeb.Api.TeamsController do
  use ServiceGraphWeb, :controller

  alias ServiceGraph.Teams
  alias ServiceGraph.Services

  def list(conn, _params) do
    list = Teams.list_teams()

    render(conn, "list.json", list: list)
  end

  def show(conn, %{"id" => id}) do
    team = Teams.get_team!(id)
    list = Services.list_services()

    render(conn, "team_page.json", services: list, team: team)
  end

  def update(conn, %{"id" => id} = attrs) do
    team = Teams.get_team!(id)
    {:ok, updated_team} = Teams.update_team(team, attrs)
    list = Services.list_services()

    render(conn, "team_page.json", services: list, team: updated_team)
  end

  def create(conn, team_params) do
    {:ok, team} = Teams.create_team(team_params)

    render(conn, "team_page.json", services: [], team: team)
  end
end
