defmodule ServiceGraph.UseCases.DeleteService do
  @moduledoc "delete service and all relations"

  alias ServiceGraph.Consumes
  alias ServiceGraph.Implementations
  alias ServiceGraph.Services
  require Logger

  def call(service_title) do
    Logger.info("UseCases.DeleteService: deleting #{service_title}")
    Implementations.delete_implementations_by_service_name(service_title)
    Consumes.delete_consumes_by_service_name(service_title)
    {_count, _nil} = Services.delete_service_by_title(service_title)

    :ok
  end
end
