defmodule ServiceGraphWeb.PageController do
  use ServiceGraphWeb, :controller

  alias ServiceGraph.Implementations
  alias ServiceGraph.UseCases.CalculateServiceSize
  alias ServiceGraph.Consumes
  alias ServiceGraph.Services

  def index(conn, _params) do
    render(conn, "index.html", nodes: nodes(), edges: edges())
  end

  defp nodes do
    services =
      Services.list_services()
      |> Enum.map(fn service ->
        size = CalculateServiceSize.call(service)

        %{
          size: 50 + size,
          shape: "dot",
          mass: size,
          label: service.title,
          id: service.title
        }
      end)

    actions =
      Implementations.list_implementations()
      |> Enum.map(fn impl ->
        %{
          shape: "box",
          mass: 5,
          label: "#" <> impl.action_name,
          id: "#{impl.service}_#{impl.action_name}"
        }
      end)

    services ++ actions
  end

  defp edges do
    implementations =
      Implementations.list_implementations()
      |> Enum.map(fn impl ->
        %{
          from: impl.service,
          to: "#{impl.service}_#{impl.action_name}"
        }
      end)

    consuming =
      Consumes.list_consumes()
      |> Enum.map(fn consume ->
        %{
          dashes: true,
          arrows: "to",
          from: consume.service,
          to: "#{consume.external_service}_#{consume.external_action_name}"
        }
      end)

    implementations ++ consuming
  end
end
