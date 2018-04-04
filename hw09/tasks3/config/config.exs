# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tasks3,
  ecto_repos: [Tasks3.Repo]

# Configures the endpoint
config :tasks3, Tasks3Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TXIjPDw7CDRHGsdqdNOhhnCrP+0/cIMt8I34pseNFULOqPwrHu+CcpBQEoe3MIny",
  render_errors: [view: Tasks3Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tasks3.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
