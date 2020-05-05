defmodule ServiceGraphWeb.ServiceControllerTest do
  use ServiceGraphWeb.ConnCase

  alias ServiceGraph.Services

  @create_attrs %{title: "some_title"}
  @invalid_attrs %{title: nil}

  def fixture(:service) do
    {:ok, service} = Services.create_service(@create_attrs)
    service
  end

  describe "index" do
    test "lists all services", %{conn: conn} do
      conn = get(conn, Routes.service_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Services"
    end
  end

  describe "new service" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.service_path(conn, :new))
      assert html_response(conn, 200) =~ "New Service"
    end
  end

  describe "create service" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.service_path(conn, :create), service: @create_attrs)

      assert %{service_name: service_name} = redirected_params(conn)
      assert redirected_to(conn) == Routes.service_path(conn, :show, service_name)

      conn = get(conn, Routes.service_path(conn, :show, service_name))
      assert html_response(conn, 200) =~ "Show Service"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.service_path(conn, :create), service: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Service"
    end
  end

  describe "delete service" do
    setup [:create_service]

    test "deletes chosen service", %{conn: conn, service: service} do
      conn = delete(conn, Routes.service_path(conn, :delete, service.title))
      assert redirected_to(conn) == Routes.service_path(conn, :index)

      assert_error_sent(404, fn -> get(conn, Routes.service_path(conn, :show, service.title)) end)
    end
  end

  defp create_service(_) do
    service = fixture(:service)
    {:ok, service: service}
  end
end
