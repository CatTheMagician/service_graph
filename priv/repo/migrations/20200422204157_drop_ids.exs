defmodule ServiceGraph.Repo.Migrations.DropIds do
  use Ecto.Migration

  def change do
    # alter table(:services) do
    # end

    alter table(:consumes) do
      add :external_action_name, :string
      add :external_service, :string
      add :service, :string
      remove :action_id, :id
      remove :service_id, :id
    end

    alter table(:implementations) do
      add :service, :string
    end
  end
end
