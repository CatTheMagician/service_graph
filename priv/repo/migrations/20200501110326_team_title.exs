defmodule ServiceGraph.Repo.Migrations.TeamTitle do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add :title, :string
    end
  end
end
