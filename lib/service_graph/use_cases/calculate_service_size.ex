defmodule ServiceGraph.UseCases.CalculateServiceSize do
  alias ServiceGraph.Services
  alias ServiceGraph.Services.Service

  @multiplier 10

  def call(%Service{} = service) do
    size = Services.consumes_count(service.title)

    size * @multiplier
  end
end
