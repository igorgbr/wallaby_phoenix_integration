defmodule FenixIntegrationWeb.PageControllerTest do
  use FenixIntegrationWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Brasil!"
  end
end
