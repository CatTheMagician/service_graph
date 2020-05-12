import Config

# Configure your database
config :service_graph, ServiceGraph.Repo,
  username: "postgres",
  password: "postgres",
  database: "service_graph_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :service_graph, ServiceGraphWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: false,
  server: true

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
