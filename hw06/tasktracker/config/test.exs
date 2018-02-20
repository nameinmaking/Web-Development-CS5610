use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tasktracker, TasktrackerWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tasktracker, Tasktracker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "tasktracker",
  password: "vene1Uqu0ahx",
  database: "tasktracker_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
