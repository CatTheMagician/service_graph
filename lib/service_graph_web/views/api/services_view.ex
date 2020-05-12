defmodule ServiceGraphWeb.Api.ServicesView do
  use ServiceGraphWeb, :view

  alias ServiceGraph.Services.Service

  def render("list.json", %{list: list}) do
    Enum.map(list, fn %Service{} = service ->
      %{
        title: service.title
      }
    end)
  end

  def render("show.json", %{service: %Service{} = service}) do
    %{
      title: service.title
    }
  end
end
