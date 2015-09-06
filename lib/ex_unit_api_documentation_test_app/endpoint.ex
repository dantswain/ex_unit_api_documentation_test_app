defmodule ExUnitApiDocumentationTestApp.Endpoint do
  use Phoenix.Endpoint, otp_app: :ex_unit_api_documentation_test_app

  socket "/socket", ExUnitApiDocumentationTestApp.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :ex_unit_api_documentation_test_app, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt docs)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_ex_unit_api_documentation_test_app_key",
    signing_salt: "wT1JgYPJ"

  plug ExUnitApiDocumentationTestApp.Router
end
