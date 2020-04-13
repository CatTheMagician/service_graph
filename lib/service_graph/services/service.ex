defmodule ServiceGraph.Services.Service do
  use Ecto.Schema
  import Ecto.Changeset

  schema "services" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
