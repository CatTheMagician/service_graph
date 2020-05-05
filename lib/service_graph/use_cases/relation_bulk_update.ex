defmodule ServiceGraph.UseCases.RelationBulkUpdate do
  @moduledoc false

  alias ServiceGraph.Services
  alias ServiceGraph.Implementations
  alias ServiceGraph.Consumes
  alias ServiceGraph.UseCases.DeleteService
  alias ServiceGraph.Repo

  def call(service_name, definitions, gitstats) do
    Repo.transaction(fn ->
      DeleteService.call(service_name)

      _service = find_service_or_create(service_name, gitstats)

      definitions
      |> Enum.map(fn str -> String.trim(str) end)
      |> Enum.map(fn str -> define_relation(service_name, str) end)
      |> Enum.map(&find_or_create_relation/1)
    end)
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

  defp find_service_or_create(title, gitstats \\ %{}) do
    service = Services.get_service_by_title(title)

    case is_nil(service) do
      true ->
        {:ok, service} =
          Services.create_service(%{title: title, gitstats: prepare_gitstats(gitstats)})

        service

      false ->
        if !is_nil(gitstats) do
          map = prepare_gitstats(gitstats)
          Services.update_service(service, %{gitstats: map})
        end

        service
    end
  end

  def prepare_gitstats(gitstats) when is_nil(gitstats) do
    %{}
  end

  def prepare_gitstats(gitstats) when is_map(gitstats) do
    gitstats
  end

  def prepare_gitstats(gitstats) do
    gitstats
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn str, acc ->
      [author, files, inserted, deleted, delta] = String.split(str, ",", trim: true)

      author = %{
        author => %{
          files: to_int(files),
          inserted: to_int(inserted),
          deleted: to_int(deleted),
          delta: to_int(delta)
        }
      }

      Map.merge(acc, author)
    end)
  end

  defp to_int(string) do
    string
    |> String.trim()
    |> String.to_integer()
  end

  defp define_relation(service_name, string) do
    clear_str = String.replace(string, ~r/\s{2,}/, " ")

    [_comment_char, _sg_tag, relation, substring] =
      Enum.map(String.split(clear_str, " "), &String.trim/1)

    case relation do
      "uses" ->
        [ext_service, action] = String.split(substring, "#")
        {:consumes, service_name, ext_service, action}

      "implements" ->
        {:implements, service_name, substring}
    end
  end
end
