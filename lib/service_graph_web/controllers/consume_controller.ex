defmodule ServiceGraphWeb.ConsumeController do
  use ServiceGraphWeb, :controller

  alias ServiceGraph.Services
  alias ServiceGraph.Implementations
  alias ServiceGraph.Consumes
  alias ServiceGraph.Consumes.Consume

  def index(conn, _params) do
    consumes = Consumes.list_consumes()
    render(conn, "index.html", consumes: consumes)
  end

  def new(conn, _params) do
    changeset = Consumes.change_consume(%Consume{})

    render(conn, "new.html",
      changeset: changeset,
      services: services_for_form(),
      actions: actions_for_form()
    )
  end

  def create(conn, %{"consume" => consume_params}) do
    case Consumes.create_consume(consume_params) do
      {:ok, consume} ->
        conn
        |> put_flash(:info, "Consume created successfully.")
        |> redirect(to: Routes.consume_path(conn, :show, consume))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html",
          changeset: changeset,
          services: services_for_form(),
          actions: actions_for_form()
        )
    end
  end

  def show(conn, %{"id" => id}) do
    consume = Consumes.get_consume!(id)
    render(conn, "show.html", consume: consume)
  end

  def edit(conn, %{"id" => id}) do
    consume = Consumes.get_consume!(id)
    changeset = Consumes.change_consume(consume)

    render(conn, "edit.html",
      consume: consume,
      changeset: changeset,
      services: services_for_form(),
      actions: actions_for_form()
    )
  end

  def update(conn, %{"id" => id, "consume" => consume_params}) do
    consume = Consumes.get_consume!(id)

    case Consumes.update_consume(consume, consume_params) do
      {:ok, consume} ->
        conn
        |> put_flash(:info, "Consume updated successfully.")
        |> redirect(to: Routes.consume_path(conn, :show, consume))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          consume: consume,
          changeset: changeset,
          services: services_for_form(),
          actions: actions_for_form()
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    consume = Consumes.get_consume!(id)
    {:ok, _consume} = Consumes.delete_consume(consume)

    conn
    |> put_flash(:info, "Consume deleted successfully.")
    |> redirect(to: Routes.consume_path(conn, :index))
  end

  defp services_for_form do
    Services.list_services()
    |> Enum.map(fn service -> {service.title, service.id} end)
  end

  defp actions_for_form do
    Implementations.list_implementations()
    |> Enum.map(fn impl -> {impl.action_name, impl.id} end)
  end
end
