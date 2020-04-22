defmodule ServiceGraph.UseCases.RelationBulkUpdate do
  @moduledoc false

  alias ServiceGraph.Services
  alias ServiceGraph.Implementations
  alias ServiceGraph.Consumes

  def call(service_name, list_of_data) do
    list_of_data
    |> Enum.map(fn str -> define_relation(service_name, str) end)
    |> Enum.map(&find_or_create_relation/1)
  end

  defp find_or_create_relation({:implements, service_name, action_name}) do
    service = find_service_or_create(service_name)

    find_implementation_or_create(service, action_name)
  end

  defp find_or_create_relation({:consumes, current_service, service_name, action_name}) do
    service = find_service_or_create(service_name)
    cur_service = find_service_or_create(current_service)

    implementaion = find_implementation_or_create(service, action_name)

    consume =
      find_consume_or_create(cur_service.title, implementaion.action_name, implementaion.service)

    consume
  end

  defp find_consume_or_create(service, ext_action_name, ext_service) do
    consume =
      Consumes.get_consume_by_service_and_action_name(service, ext_service, ext_action_name)

    case is_nil(consume) do
      true ->
        {:ok, consume} =
          Consumes.create_consume(%{
            external_action_name: ext_action_name,
            service: service,
            external_service: ext_service
          })

        consume

      false ->
        consume
    end
  end

  defp find_implementation_or_create(service, action_name) do
    implementation =
      Implementations.get_implementation_by_service_and_action_name(service.title, action_name)

    case is_nil(implementation) do
      true ->
        {:ok, implementaion} =
          Implementations.create_implementation(%{
            action_name: action_name,
            service: service.title
          })

        implementaion

      false ->
        implementation
    end
  end

  defp find_service_or_create(title) do
    service = Services.get_service_by_title(title)

    case is_nil(service) do
      true ->
        {:ok, service} = Services.create_service(%{title: title})
        service

      false ->
        service
    end
  end

  defp define_relation(service_name, string) do
    [relation, substring] = String.split(string, " ")

    case relation do
      "uses" ->
        [ext_service, action] = String.split(substring, "#")
        {:consumes, service_name, ext_service, action}

      "implements" ->
        {:implements, service_name, substring}
    end
  end
end
