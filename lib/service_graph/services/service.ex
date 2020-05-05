defmodule ServiceGraph.Services.Service do
  use Ecto.Schema
  import Ecto.Changeset

  schema "services" do
    field :title, :string
    field :gitstats, :map, default: %{}

    timestamps()
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:title, :gitstats])
    |> validate_required([:title])
  end
end
