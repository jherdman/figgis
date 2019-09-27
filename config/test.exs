use Mix.Config

# Configure your database
config :figgis, Figgis.Repo,
  username: "postgres",
  password: "postgres",
  database: "figgis_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :figgis, FiggisWeb.Endpoint,
  http: [port: 4002],
  server: true,
  debug_errors: false,
  check_origin: false

# Print only warnings and errors during test
config :logger, level: :warn

config :figgis, sql_sandbox: true
