# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :service_graph,
  ecto_repos: [ServiceGraph.Repo]

# Configures the endpoint
config :service_graph, ServiceGraphWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YZmifKo8MBvt4C/LCGzcCBxHL4fu3oVPbDg7F8wHFRwa3jcu7DIcp6U4+O6orD8d",
  render_errors: [view: ServiceGraphWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ServiceGraph.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
