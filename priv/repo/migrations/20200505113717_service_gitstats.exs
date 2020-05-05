defmodule ServiceGraph.Repo.Migrations.ServiceGitstats do
  use Ecto.Migration

  def change do
    alter table(:services) do
      add :gitstats, :jsonb
    end
  end
end
