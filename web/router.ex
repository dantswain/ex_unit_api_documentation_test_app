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

  scope "/docs", ExUnitApiDocumentation do
    pipe_through :browser

    get "/", DocsController, :index
  end
end
