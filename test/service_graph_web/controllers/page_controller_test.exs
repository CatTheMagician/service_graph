defmodule ServiceGraphWeb.PageControllerTest do
  use ServiceGraphWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "ServiceGraph"
  end
end
