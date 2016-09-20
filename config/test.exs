use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :api_with_phoenix_demo, ApiWithPhoenixDemo.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :api_with_phoenix_demo, ApiWithPhoenixDemo.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "root",
  database: "api_with_phoenix_demo_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
