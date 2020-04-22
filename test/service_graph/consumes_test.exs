defmodule ServiceGraph.ConsumesTest do
  use ServiceGraph.DataCase

  alias ServiceGraph.Consumes

  describe "consumes" do
    alias ServiceGraph.Consumes.Consume

    @valid_attrs %{
      external_service: "Motivation",
      external_action_name: "do_it!",
      service: "Example"
    }
    @update_attrs %{
      external_service: "Motivation",
      external_action_name: "just_do_it!",
      service: "Example"
    }
    @invalid_attrs %{
      external_service: "Motivation",
      external_action_name: nil,
      service: "Example"
    }

    def consume_fixture(attrs \\ %{}) do
      {:ok, consume} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Consumes.create_consume()

      consume
    end

    test "list_consumes/0 returns all consumes" do
      consume = consume_fixture()
      assert Consumes.list_consumes() == [consume]
    end

    test "get_consume!/1 returns the consume with given id" do
      consume = consume_fixture()
      assert Consumes.get_consume!(consume.id) == consume
    end

    test "create_consume/1 with valid data creates a consume" do
      assert {:ok, %Consume{} = consume} = Consumes.create_consume(@valid_attrs)
    end

    test "create_consume/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Consumes.create_consume(@invalid_attrs)
    end

    test "update_consume/2 with valid data updates the consume" do
      consume = consume_fixture()
      assert {:ok, %Consume{} = consume} = Consumes.update_consume(consume, @update_attrs)
    end

    test "update_consume/2 with invalid data returns error changeset" do
      consume = consume_fixture()
      assert {:error, %Ecto.Changeset{}} = Consumes.update_consume(consume, @invalid_attrs)
      assert consume == Consumes.get_consume!(consume.id)
    end

    test "delete_consume/1 deletes the consume" do
      consume = consume_fixture()
      assert {:ok, %Consume{}} = Consumes.delete_consume(consume)
      assert_raise Ecto.NoResultsError, fn -> Consumes.get_consume!(consume.id) end
    end

    test "change_consume/1 returns a consume changeset" do
      consume = consume_fixture()
      assert %Ecto.Changeset{} = Consumes.change_consume(consume)
    end
  end
end
