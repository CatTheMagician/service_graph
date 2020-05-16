defmodule ServiceGraphWeb.PageController do
  use ServiceGraphWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
