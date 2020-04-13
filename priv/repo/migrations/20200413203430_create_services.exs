defmodule ServiceGraph.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :title, :string

      timestamps()
    end
  end
end
