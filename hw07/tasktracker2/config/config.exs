# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tasktracker2,
  ecto_repos: [Tasktracker2.Repo]

# Configures the endpoint
config :tasktracker2, Tasktracker2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aNamerZId/8hog1wAq0lDyz7zE2MjJyz24r/pvkFoO3qWn7+/QWJNxe76B3gqeRR",
  render_errors: [view: Tasktracker2Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tasktracker2.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
