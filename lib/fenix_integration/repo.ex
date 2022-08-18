defmodule FenixIntegration.Repo do
  use Ecto.Repo,
    otp_app: :fenix_integration,
    adapter: Ecto.Adapters.Postgres
end
