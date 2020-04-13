defmodule ServiceGraph.ImplementationsTest do
  use ServiceGraph.DataCase

  alias ServiceGraph.Implementations

  describe "implementations" do
    alias ServiceGraph.Implementations.Implementation

    @valid_attrs %{action_name: "some action_name", service_id: 1}
    @update_attrs %{action_name: "some updated action_name", service_id: 2}
    @invalid_attrs %{action_name: nil}

    def implementation_fixture(attrs \\ %{}) do
      {:ok, implementation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Implementations.create_implementation()

      implementation
    end

    test "list_implementations/0 returns all implementations" do
      implementation = implementation_fixture()
      assert Implementations.list_implementations() == [implementation]
    end

    test "get_implementation!/1 returns the implementation with given id" do
      implementation = implementation_fixture()
      assert Implementations.get_implementation!(implementation.id) == implementation
    end

    test "create_implementation/1 with valid data creates a implementation" do
      assert {:ok, %Implementation{} = implementation} =
               Implementations.create_implementation(@valid_attrs)

      assert implementation.action_name == "some action_name"
    end

    test "create_implementation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Implementations.create_implementation(@invalid_attrs)
    end

    test "update_implementation/2 with valid data updates the implementation" do
      implementation = implementation_fixture()

      assert {:ok, %Implementation{} = implementation} =
               Implementations.update_implementation(implementation, @update_attrs)

      assert implementation.action_name == "some updated action_name"
    end

    test "update_implementation/2 with invalid data returns error changeset" do
      implementation = implementation_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Implementations.update_implementation(implementation, @invalid_attrs)

      assert implementation == Implementations.get_implementation!(implementation.id)
    end

    test "delete_implementation/1 deletes the implementation" do
      implementation = implementation_fixture()
      assert {:ok, %Implementation{}} = Implementations.delete_implementation(implementation)

      assert_raise Ecto.NoResultsError, fn ->
        Implementations.get_implementation!(implementation.id)
      end
    end

    test "change_implementation/1 returns a implementation changeset" do
      implementation = implementation_fixture()
      assert %Ecto.Changeset{} = Implementations.change_implementation(implementation)
    end
  end
end
