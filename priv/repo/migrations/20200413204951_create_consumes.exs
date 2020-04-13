defmodule ServiceGraph.Repo.Migrations.CreateConsumes do
  use Ecto.Migration

  def change do
    create table(:consumes) do
      add :action_id, :id
      add :service_id, :id

      timestamps()
    end

    create index(:consumes, [:action_id])
    create index(:consumes, [:service_id])
  end
end
