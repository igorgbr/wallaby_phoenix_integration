defmodule FenixIntegrationWeb.IndexPageTest do
  use FenixIntegrationWeb.IntegrationCase, async: true

  import Wallaby.Query, only: [css: 2]

  test "verify a 'Resources' section", %{session: session} do
    session
    |> visit("/")
    |> find(css("section", count: 3))
    |> Enum.at(2)
    |> assert_has(css("h2", text: "Resources"))
  end

  test "has a h1 tag", %{session: session} do
    session
    |> visit("/")
    |> find(css(".phx-hero", count: 1))
    |> assert_has(css("h1", text: "Welcome to Brasil"))
  end
end
