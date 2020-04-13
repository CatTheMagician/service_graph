defmodule ServiceGraph.Repo.Migrations.CreateImplementations do
  use Ecto.Migration

  def change do
    create table(:implementations) do
      add :action_name, :string
      add :service_id, :id

      timestamps()
    end

    create index(:implementations, [:service_id])
  end
end
