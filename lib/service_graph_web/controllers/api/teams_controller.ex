defmodule ServiceGraphWeb.Api.TeamsController do
  use ServiceGraphWeb, :controller

  alias ServiceGraph.Teams

  def list(conn, _params) do
    list = Teams.list_teams()

    render(conn, "list.json", list: list)
  end

  def show(conn, %{"id" => id}) do
    team = Teams.get_team!(id)

    render(conn, "show.json", team: team)
  end
end
