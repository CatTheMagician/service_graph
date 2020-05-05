defmodule ServiceGraph.UseCases.CalculateServiceSize do
  alias ServiceGraph.Services
  alias ServiceGraph.Services.Service

  @multiplier 20

  def call(%Service{} = service) do
    size = Services.consumes_count(service.title)

    size * @multiplier
  end
end
