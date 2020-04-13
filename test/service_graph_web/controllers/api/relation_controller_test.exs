defmodule ServiceGraphWeb.Api.RelationControllerTest do
  use ServiceGraphWeb.ConnCase

  test "POST /api/relations/:service_name/bulk_definition", %{conn: conn} do
    conn = post(conn, "/api/relations/foo/bulk_definition", %{"definitions" => []})
    assert response(conn, 200) =~ "OK"
  end
end
