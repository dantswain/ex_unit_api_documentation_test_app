defmodule ExUnitApiDocumentationTestApp.ApiController do
  use ExUnitApiDocumentationTestApp.Web, :controller

  def index(conn, _params) do
    conn
    |> put_status(200)
    |> json %{ok: true}
  end
end
