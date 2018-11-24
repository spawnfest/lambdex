# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lambdex,
  ecto_repos: [Lambdex.Repo]

# Configures the endpoint
config :lambdex, LambdexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7M9A+mM97h5WhZ7OMQVGmj3oznvmO9AliBbW+n7l50o4chnL8o95d7rB+dZgINgW",
  render_errors: [view: LambdexWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Lambdex.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
