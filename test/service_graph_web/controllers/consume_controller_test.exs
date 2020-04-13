defmodule ServiceGraphWeb.ConsumeControllerTest do
  use ServiceGraphWeb.ConnCase

  alias ServiceGraph.Consumes
  alias ServiceGraph.Services
  alias ServiceGraph.Implementations

  @create_attrs %{service_id: 3, action_id: 1}
  @update_attrs %{service_id: 2, action_id: 1}
  @invalid_attrs %{}

  def fixture(:consume) do
    {:ok, service} = Services.create_service(%{title: "example"})

    {:ok, implementation} =
      Implementations.create_implementation(%{
        service_id: service.id,
        action_name: "action_name"
      })

    {:ok, consume} =
      Consumes.create_consume(%{service_id: service.id, action_id: implementation.id})

    consume
  end

  describe "index" do
    test "lists all consumes", %{conn: conn} do
      conn = get(conn, Routes.consume_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Consumes"
    end
  end

  describe "new consume" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.consume_path(conn, :new))
      assert html_response(conn, 200) =~ "New Consume"
    end
  end

  describe "create consume" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.consume_path(conn, :create), consume: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.consume_path(conn, :show, id)

      conn = get(conn, Routes.consume_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Consume"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.consume_path(conn, :create), consume: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Consume"
    end
  end

  describe "edit consume" do
    setup [:create_consume]

    test "renders form for editing chosen consume", %{conn: conn, consume: consume} do
      conn = get(conn, Routes.consume_path(conn, :edit, consume))
      assert html_response(conn, 200) =~ "Edit Consume"
    end
  end

  describe "update consume" do
    setup [:create_consume]

    test "redirects when data is valid", %{conn: conn, consume: consume} do
      conn = put(conn, Routes.consume_path(conn, :update, consume), consume: @update_attrs)
      assert redirected_to(conn) == Routes.consume_path(conn, :show, consume)

      conn = get(conn, Routes.consume_path(conn, :show, consume))
      assert html_response(conn, 200)
    end
  end

  describe "delete consume" do
    setup [:create_consume]

    test "deletes chosen consume", %{conn: conn, consume: consume} do
      conn = delete(conn, Routes.consume_path(conn, :delete, consume))
      assert redirected_to(conn) == Routes.consume_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.consume_path(conn, :show, consume))
      end
    end
  end

  defp create_consume(_) do
    consume = fixture(:consume)
    {:ok, consume: consume}
  end
end
