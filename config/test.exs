use Mix.Config

database_url = "#{System.get_env("DATABASE_URL")}test#{System.get_env("MIX_TEST_PARTITION")}"

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :nfl_rushing, NflRushing.Repo,
  url: database_url,
  pool: Ecto.Adapters.SQL.Sandbox

# Configure the database for GitHub Actions
if System.get_env("GITHUB_ACTIONS") do
  config :app, App.Repo,
    username: "postgres",
    password: "postgres"
end

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nfl_rushing, NflRushingWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
