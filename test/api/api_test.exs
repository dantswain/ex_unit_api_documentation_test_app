defmodule ExUnitApiDocumentationTestApp.ApiTest do
  use ExUnit.Case

  alias ExUnitApiDocumentationTestApp.Support.API

  setup_all do
    API.launch

    ExUnitApiDocumentation.start
    ExUnitApiDocumentation.start_doc("api")

    on_exit fn ->
      # actually write out the docs
      ExUnitApiDocumentation.write_json
    end
  end

  test "GET /" do
    got = API.get!("/")
    assert got.status_code == 200
  end
end
