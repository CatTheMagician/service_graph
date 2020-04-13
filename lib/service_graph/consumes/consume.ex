defmodule ServiceGraph.Consumes.Consume do
  use Ecto.Schema
  import Ecto.Changeset

  schema "consumes" do
    field :action_id, :id
    field :service_id, :id

    timestamps()
  end

  @doc false
  def changeset(consume, attrs) do
    consume
    |> cast(attrs, [:service_id, :action_id])
    |> validate_required([:service_id, :action_id])
  end
end
