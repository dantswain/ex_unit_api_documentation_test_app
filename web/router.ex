defmodule ExUnitApiDocumentationTestApp.Router do
  use ExUnitApiDocumentationTestApp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExUnitApiDocumentationTestApp do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ExUnitApiDocumentationTestApp do
    pipe_through :api

    get "/", ApiController, :index
  end

  pipeline :docs do
    plug Plug.Static,
      at: "/", from: :ex_unit_api_documentation, gzip: false,
      only: ~w(css fonts images js favicon.ico robots.txt)
  end

  scope "/docs", ExUnitApiDocumentation do
    pipe_through :browser
    pipe_through :docs

    get "/", DocsController, :index
  end
end
