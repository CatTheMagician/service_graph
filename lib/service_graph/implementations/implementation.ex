defmodule ServiceGraph.Implementations.Implementation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "implementations" do
    field :action_name, :string
    field :service, :string

    timestamps()
  end

  @doc false
  def changeset(implementation, attrs) do
    implementation
    |> cast(attrs, [:action_name, :service])
    |> validate_required([:action_name, :service])
  end
end
