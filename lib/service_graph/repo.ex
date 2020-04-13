defmodule ServiceGraph.Repo do
  use Ecto.Repo,
    otp_app: :service_graph,
    adapter: Ecto.Adapters.Postgres
end
