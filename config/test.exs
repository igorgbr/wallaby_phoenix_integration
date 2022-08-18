import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :fenix_integration, FenixIntegration.Repo,
  username: "igor",
  password: "1234",
  hostname: "localhost",
  database: "fenix_integration_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fenix_integration, FenixIntegrationWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "AeuvkYtKJMPHcWVkGJ6BamPJATJ8jo4CFy5/8VcM92PSVYXAIl2nyBzw6Illng0w",
  server: true

  config :fenix_integration, :sql_sandbox, true
  config :wallaby, screenshot_dir: "/screenshots"
  config :wallaby, screenshot_on_failure: true

# In test we don't send emails.
config :fenix_integration, FenixIntegration.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
