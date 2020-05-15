defmodule ServiceGraphWeb.Api.ServicesView do
  use ServiceGraphWeb, :view

  alias ServiceGraph.Services.Service

  def render("list.json", %{list: list}) do
    Enum.map(list, fn %Service{} = service ->
      service.title
    end)
  end

  def render("show.json", %{service: %Service{} = service}) do
    %{
      title: service.title
    }
  end

  def render("delete.json", %{result: :ok}) do
    %{
      result: :ok
    }
  end
end
