defmodule ServiceGraphWeb.Api.RelationController do
  use ServiceGraphWeb, :controller

  alias ServiceGraph.UseCases.RelationBulkUpdate

  def bulk_definition(conn, %{"definitions" => definitions, "service_name" => service} = _params) do
    RelationBulkUpdate.call(service, definitions)

    resp(conn, 200, "OK")
  end
end
