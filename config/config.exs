# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_app,
  ecto_repos: [ElixirApp.Repo]

# Configures the endpoint
config :elixir_app, ElixirAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2MBlKA1pQ3KWhHeli0AgXHam6vB9S7IzfqwIuT1UCI37Yv23MMNIYnMN5G1KFA37",
  render_errors: [view: ElixirAppWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ElixirApp.PubSub,
  live_view: [signing_salt: "ywj2Y/SS"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
