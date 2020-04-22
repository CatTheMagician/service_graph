defmodule ServiceGraph.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :color, :string
    field :services, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:services, :color])
    |> validate_required([:services, :color])
  end
end
