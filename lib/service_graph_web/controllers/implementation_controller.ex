defmodule ServiceGraphWeb.ImplementationController do
  use ServiceGraphWeb, :controller

  alias ServiceGraph.Services
  alias ServiceGraph.Implementations
  alias ServiceGraph.Implementations.Implementation

  def index(conn, _params) do
    implementations = Implementations.list_implementations()
    render(conn, "index.html", implementations: implementations)
  end

  def new(conn, _params) do
    changeset = Implementations.change_implementation(%Implementation{})
    render(conn, "new.html", changeset: changeset, services: services_for_form())
  end

  def create(conn, %{"implementation" => implementation_params}) do
    case Implementations.create_implementation(implementation_params) do
      {:ok, implementation} ->
        conn
        |> put_flash(:info, "Implementation created successfully.")
        |> redirect(to: Routes.implementation_path(conn, :show, implementation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, services: services_for_form())
    end
  end

  def show(conn, %{"id" => id}) do
    implementation = Implementations.get_implementation!(id)
    render(conn, "show.html", implementation: implementation)
  end

  def edit(conn, %{"id" => id}) do
    implementation = Implementations.get_implementation!(id)
    changeset = Implementations.change_implementation(implementation)

    render(conn, "edit.html",
      implementation: implementation,
      changeset: changeset,
      services: services_for_form()
    )
  end

  def update(conn, %{"id" => id, "implementation" => implementation_params}) do
    implementation = Implementations.get_implementation!(id)

    case Implementations.update_implementation(implementation, implementation_params) do
      {:ok, implementation} ->
        conn
        |> put_flash(:info, "Implementation updated successfully.")
        |> redirect(to: Routes.implementation_path(conn, :show, implementation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          implementation: implementation,
          changeset: changeset,
          services: services_for_form()
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    implementation = Implementations.get_implementation!(id)
    {:ok, _implementation} = Implementations.delete_implementation(implementation)

    conn
    |> put_flash(:info, "Implementation deleted successfully.")
    |> redirect(to: Routes.implementation_path(conn, :index))
  end

  defp services_for_form do
    Services.list_services()
    |> Enum.map(fn service -> {service.title, service.id} end)
  end
end
