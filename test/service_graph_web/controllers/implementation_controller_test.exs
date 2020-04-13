defmodule ServiceGraphWeb.ImplementationControllerTest do
  use ServiceGraphWeb.ConnCase

  alias ServiceGraph.Implementations
  alias ServiceGraph.Services

  @create_attrs %{action_name: "some action_name", service_id: 1}
  @update_attrs %{action_name: "some updated action_name", service_id: 2}
  @invalid_attrs %{action_name: nil}

  def fixture(:implementation) do
    {:ok, service} = Services.create_service(%{title: "example"})

    {:ok, implementation} =
      Implementations.create_implementation(%{
        service_id: service.id,
        action_name: "action_name"
      })

    implementation
  end

  describe "index" do
    test "lists all implementations", %{conn: conn} do
      conn = get(conn, Routes.implementation_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Implementations"
    end
  end

  describe "new implementation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.implementation_path(conn, :new))
      assert html_response(conn, 200) =~ "New Implementation"
    end
  end

  describe "create implementation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.implementation_path(conn, :create), implementation: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.implementation_path(conn, :show, id)

      conn = get(conn, Routes.implementation_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Implementation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.implementation_path(conn, :create), implementation: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Implementation"
    end
  end

  describe "edit implementation" do
    setup [:create_implementation]

    test "renders form for editing chosen implementation", %{
      conn: conn,
      implementation: implementation
    } do
      conn = get(conn, Routes.implementation_path(conn, :edit, implementation))
      assert html_response(conn, 200) =~ "Edit Implementation"
    end
  end

  describe "update implementation" do
    setup [:create_implementation]

    test "redirects when data is valid", %{conn: conn, implementation: implementation} do
      conn =
        put(conn, Routes.implementation_path(conn, :update, implementation),
          implementation: @update_attrs
        )

      assert redirected_to(conn) == Routes.implementation_path(conn, :show, implementation)

      conn = get(conn, Routes.implementation_path(conn, :show, implementation))
      assert html_response(conn, 200) =~ "some updated action_name"
    end

    test "renders errors when data is invalid", %{conn: conn, implementation: implementation} do
      conn =
        put(conn, Routes.implementation_path(conn, :update, implementation),
          implementation: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Implementation"
    end
  end

  describe "delete implementation" do
    setup [:create_implementation]

    test "deletes chosen implementation", %{conn: conn, implementation: implementation} do
      conn = delete(conn, Routes.implementation_path(conn, :delete, implementation))
      assert redirected_to(conn) == Routes.implementation_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.implementation_path(conn, :show, implementation))
      end
    end
  end

  defp create_implementation(_) do
    implementation = fixture(:implementation)
    {:ok, implementation: implementation}
  end
end
