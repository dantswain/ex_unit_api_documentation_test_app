defmodule ExUnitApiDocumentationTestApp.PageController do
  use ExUnitApiDocumentationTestApp.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
