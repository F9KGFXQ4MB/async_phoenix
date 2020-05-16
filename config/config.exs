# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :myapp,
  ecto_repos: [Myapp.Repo]

# Configures the endpoint
config :myapp, MyappWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dXri1imtT+r808TJbVaRwr5prvuRrMQbjxcLdKbb920ZORBCDijWz0w9S1fTazLI",
  render_errors: [view: MyappWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Myapp.PubSub,
  live_view: [signing_salt: "F5pQQo1I"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
