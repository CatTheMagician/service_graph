defmodule ServiceGraph.UseCases.GraphVis do
  @moduledoc false

  alias ServiceGraph.Implementations
  alias ServiceGraph.Consumes
  alias ServiceGraph.Services
  alias ServiceGraph.Teams

  @default_color "#D2E5FF"

  def call() do
    colors = select_colors()
    teams = teams()
    nodes = nodes(colors)
    edges = edges(colors)

    %{
      teams: teams,
      nodes: nodes,
      edges: edges
    }
  end

  defp color_for_service_nodes(colors, service) do
    %{
      background: colors[service] || @default_color,
      highlight: %{
        background: colors[service] || @default_color
      }
    }
  end

  defp color_for_service_edges(colors, service) do
    %{
      color: colors[service] || @default_color,
      highlight: colors[service] || @default_color
    }
  end

  defp nodes(colors) do
    services =
      Services.list_services_with_consumes_count()
      |> Enum.map(fn {service_title, count_of_consumes} ->
        size = 50 + count_of_consumes * 10

        %{
          size: size,
          shape: "dot",
          mass: count_of_consumes / 4,
          color: color_for_service_nodes(colors, service_title),
          label: service_title,
          id: service_title
        }
      end)

    actions =
      Implementations.list_implementations()
      |> Enum.map(fn impl ->
        %{
          shape: "box",
          mass: 3,
          # color: color_for_service_nodes(colors, impl.service),
          color: %{
            background: "WhiteSmoke",
            highlight: %{
              background: @default_color
            }
          },
          label: "#" <> impl.action_name,
          id: "#{impl.service}_#{impl.action_name}"
        }
      end)

    services ++ actions
  end

  defp teams do
    Teams.list_teams()
    |> Enum.map(fn team ->
      %{
        services: team.services,
        title: team.title,
        color: team.color
      }
    end)
  end

  defp edges(colors) do
    implementations =
      Implementations.list_implementations()
      |> Enum.map(fn impl ->
        %{
          width: 2,
          selectionWidth: 8,
          shadow: %{
            size: 5,
            x: 0,
            y: 0,
            color: "#2d7be9",
            enabled: true
          },
          from: impl.service,
          color: color_for_service_edges(colors, impl.service),
          to: "#{impl.service}_#{impl.action_name}"
        }
      end)

    consuming =
      Consumes.list_consumes()
      |> Enum.map(fn consume ->
        %{
          dashes: true,
          shadow: %{
            size: 5,
            x: 0,
            y: 0,
            color: "#2d7be9",
            enabled: true
          },
          width: 2,
          selectionWidth: 8,
          arrows: "to",
          color: color_for_service_edges(colors, consume.service),
          from: consume.service,
          to: "#{consume.external_service}_#{consume.external_action_name}"
        }
      end)

    implementations ++ consuming
  end

  defp select_colors() do
    Teams.list_teams()
    |> Enum.map(fn team -> Enum.map(team.services, fn service -> {service, team.color} end) end)
    |> List.flatten()
    |> Map.new()
  end
end
