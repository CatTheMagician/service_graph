defmodule ServiceGraphWeb.Api.RelationController do
  use ServiceGraphWeb, :controller

  alias ServiceGraph.UseCases.RelationBulkUpdate

  def bulk_definition(conn, %{"Definitions" => definitions, "service_name" => service} = params) do
    RelationBulkUpdate.call(service, definitions, params["Gitstats"])

    resp(conn, 200, "OK")
  end
end
