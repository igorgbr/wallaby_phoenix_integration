defmodule FenixIntegrationWeb.PageController do
  use FenixIntegrationWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
