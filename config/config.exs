# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api_with_phoenix_demo,
  ecto_repos: [ApiWithPhoenixDemo.Repo]

# Configures the endpoint
config :api_with_phoenix_demo, ApiWithPhoenixDemo.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9RR0aapcKrP04bmbl2dpsgmfpRLiVCS3tZ8LqR2ZNkZigF1H+N+aibNjiXs+jAjQ",
  render_errors: [view: ApiWithPhoenixDemo.ErrorView, accepts: ~w(json)],
  pubsub: [name: ApiWithPhoenixDemo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  # Guardian configuration
  config :guardian, Guardian,
    hooks: GuardianDb,
    allowed_algos: ["HS512"],
    verify_module: Guardian.JWT,
    issuer: "Elixir",
    ttl: { 30, :days },
    verify_issuer: true,
    secret_key: "i/OrQgqlsIfOwEwHD08B7e50einJJPMkzXFl9uaSXHwe6I21TJ8yqywyz9NMSlxv",
    serializer: ApiWithPhoenixDemo.Auth.Serializer

  config :guardian_db, GuardianDb,
    repo: ApiWithPhoenixDemo.Repo,
    schema_name: "user_tokens"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
