defmodule ServiceGraphWeb.ServiceController do
  use ServiceGraphWeb, :controller

  alias ServiceGraph.Services
  alias ServiceGraph.Services.Service
  alias ServiceGraph.UseCases.DeleteService

  def index(conn, _params) do
    services = Services.list_services()
    render(conn, "index.html", services: services)
  end

  def new(conn, _params) do
    changeset = Services.change_service(%Service{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"service" => service_params}) do
    case Services.create_service(service_params) do
      {:ok, service} ->
        conn
        |> put_flash(:info, "Service created successfully.")
        |> redirect(to: Routes.service_path(conn, :show, service.title))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"service_name" => title}) do
    service = Services.get_service_by_title!(title)
    render(conn, "show.html", service: service)
  end

  def delete(conn, %{"service_name" => title}) do
    :ok = DeleteService.call(title)

    conn
    |> put_flash(:info, "Service deleted successfully.")
    |> redirect(to: Routes.service_path(conn, :index))
  end
end
