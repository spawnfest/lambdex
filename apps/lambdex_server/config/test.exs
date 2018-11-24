use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lambdex_server, LambdexServerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :lambdex_server, LambdexServer.Repo,
  username: "postgres",
  password: "postgres",
  database: "lambdex_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configures Guardian
config :lambdex_server, LambdexServer.Auth.Guardian,
  issuer: "lambdex",
  secret_key: "UZbz4Z2nyv9PAN5hAGvgCO4fpeHueAfQv0PNrnquY8KNG+6u5rAh2IE9U+NMPBiM"
