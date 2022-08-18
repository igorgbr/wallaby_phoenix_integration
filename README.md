# Wallaby - Testes de inetegraçao no Elixir 

## Configuração 📝

1. Instalar [PhantomJS](https://phantomjs.org/) (?)
    
    ```bash
    npm install -g phantomjs
    ```
    
2. Inserir a dependencia no arquivo `mix.exs`
    
    ```elixir
    {:wallaby, "~> 0.23", [runtime: false, only: :test]}
    ```
    
3. No arquivo `text.exs` habilitar o server para rodar com o teste e o banco para funcionar com múltiplos browsers.
    
    ```elixir
    config :my_app, MyApp.Endpoint
    	http: [port: 4002]
    	server: true
    
    config :my_app, :sql_sandbox, true
    config :wallaby, screenshot_on_failure: true # Essa parte não funcionou pra mim
    ```
    
4. No arquivo `enpoint.ex` insira a condicional do **Plug** chamando a `variável de ambiente` que nós criamos.
    
    ```elixir
    if Application.get_env(:my_app, :sql_sandbox) do
    	plug Phoenix.Ecto.SQL.Sandbox
    end
    ```
    
5. No arquivo `test/support/test_helper.ex` inserir. (?)
    
    ```elixir
    {:ok, _} = Application.ensure_all_started(:wallaby)
    Application.put_env(:wallaby, :base_url, MyApp.Endpoint.url())
    ```
    

## Criando os testes 🛠️

1. Vamos criar um arquivo `test/support/integration_case.ex`
    
    ```elixir
    defmodule MyApp.IntegrationCase do
      @moduledoc """
      This module defines the test case to be used by
      integration tests
      """
    
      use ExUnit.CaseTemplate
    
      using do
        quote do
          use Wallaby.DSL
          alias MyApp.Repo
    
          import Ecto
          import Ecto.Changeset
          import Ecto.Query
    
          import MyApp.Router.Helpers
        end
      end
    
      setup tags do
        pid = Ecto.Adapters.SQL.Sandbox.start_owner!(MyApp.Repo, shared: not tags[:async])
        on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
    
        metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(MyApp.Repo, self())
        {:ok, session} = Wallaby.start_session(metadata: metadata)
        {:ok, session: session}
      end
    end
    ```
    
2. Vamos criar um arquivo `test/integration/index_page_test.ex`
    
    ```elixir
    defmodule MyApp.IndexPageTest do
      use MyApp.IntegrationCase, async: true
    
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
    ```
    
    O teste verifica a Home padrão do Phoenix que esta rodando em “/”