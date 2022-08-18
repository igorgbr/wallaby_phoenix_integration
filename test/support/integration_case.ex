defmodule FenixIntegrationWeb.IntegrationCase do
  @moduledoc """
  This module defines the test case to be used by
  integration tests
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL
      alias FenixIntegration.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import FenixIntegrationWeb.Router.Helpers
    end
  end

  setup tags do
    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(FenixIntegration.Repo, shared: not tags[:async])
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(FenixIntegration.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
