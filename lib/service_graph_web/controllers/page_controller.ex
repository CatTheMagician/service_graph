defmodule ServiceGraphWeb.PageController do
  use ServiceGraphWeb, :controller

  alias ServiceGraph.Implementations
  alias ServiceGraph.Consumes
  alias ServiceGraph.Services

  def index(conn, _params) do
    render(conn, "index.html", nodes: nodes(), edges: edges())
  end

  defp nodes do
    services =
      Services.list_services()
      |> Enum.map(fn service ->
        %{
          size: 50,
          shape: "dot",
          mass: 1,
          label: service.title,
          id: "service_#{service.id}"
        }
      end)

    actions =
      Implementations.list_implementations()
      |> Enum.map(fn impl ->
        %{shape: "box", mass: 5, label: "#" <> impl.action_name, id: "action_#{impl.id}"}
      end)

    services ++ actions
  end

  defp edges do
    implementations =
      Implementations.list_implementations()
      |> Enum.map(fn impl ->
        %{
          from: "service_#{impl.service_id}",
          to: "action_#{impl.id}"
        }
      end)

    consuming =
      Consumes.list_consumes()
      |> Enum.map(fn consume ->
        %{
          dashes: true,
          arrows: "to",
          from: "service_#{consume.service_id}",
          to: "action_#{consume.action_id}"
        }
      end)

    implementations ++ consuming
  end
end
