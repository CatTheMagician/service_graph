defmodule ServiceGraph.Implementations.Implementation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "implementations" do
    field :action_name, :string
    field :service_id, :id

    timestamps()
  end

  @doc false
  def changeset(implementation, attrs) do
    implementation
    |> cast(attrs, [:action_name, :service_id])
    |> validate_required([:action_name, :service_id])
  end
end
