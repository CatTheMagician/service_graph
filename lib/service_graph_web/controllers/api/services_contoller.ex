defmodule ServiceGraphWeb.Api.ServicesController do
  use ServiceGraphWeb, :controller

  alias ServiceGraph.Services
  alias ServiceGraph.UseCases.DeleteService

  def list(conn, _params) do
    list = Services.list_services()

    render(conn, "list.json", list: list)
  end

  def show(conn, %{"title" => title}) do
    service = Services.get_service_by_title!(title)

    render(conn, "show.json", service: service)
  end

  def delete(conn, %{"title" => title}) do
    DeleteService.call(title)

    render(conn, "delete.json", result: :ok)
  end
end
