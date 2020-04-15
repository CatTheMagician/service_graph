defmodule ServiceGraph.UseCases.DeleteService do
  @moduledoc "delete service and all relations"

  alias ServiceGraph.Consumes
  alias ServiceGraph.Implementations
  alias ServiceGraph.Services
  require Logger

  def call(service_id) do
    service = Services.get_service!(service_id)
    Logger.info("UseCases.DeleteService: deleting #{service.title}")
    Implementations.delete_implementations_by_service_id(service.id)
    Consumes.delete_consumes_by_service_id(service.id)
    {:ok, _service} = Services.delete_service(service)

    :ok
  end
end
