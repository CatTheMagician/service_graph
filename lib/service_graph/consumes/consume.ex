defmodule ServiceGraph.Consumes.Consume do
  use Ecto.Schema
  import Ecto.Changeset

  schema "consumes" do
    field :external_service, :string
    field :external_action_name, :string
    field :service, :string

    timestamps()
  end

  @doc false
  def changeset(consume, attrs) do
    consume
    |> cast(attrs, [:external_service, :external_action_name, :service])
    |> validate_required([:external_service, :external_action_name, :service])
  end
end
