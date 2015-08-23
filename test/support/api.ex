defmodule ExUnitApiDocumentationTestApp.Support.API do
  use HTTPoison.Base

  def launch do
    HTTPoison.start

    endpoint_config =
      Application.get_env(:ex_unit_api_documentation_test_app,
                          ExUnitApiDocumentationTestApp.Endpoint)
    |> Keyword.put(:server, true)
    :ok = Application.put_env(:ex_unit_api_documentation_test_app,
                              ExUnitApiDocumentationTestApp.Endpoint,
                              endpoint_config)

    :ok = Application.stop(:ex_unit_api_documentation_test_app)
    {:ok, _} = Application.ensure_all_started(:ex_unit_api_documentation_test_app)
  end

  # prepend the url with the server api route
  def process_url(url) do
    api_url <> url
  end

  # try to decode response bodies as JSON
  #   but reply with the raw body if there are
  #   any errors (e.g., invalid JSON)
  def process_response_body(body) do
    try do
      Poison.decode!(body, keys: :atoms!)
    rescue
      _ -> body
    end
  end

  # always convert the request body to JSON
  def process_request_body(body) do
    Poison.encode!(body)
  end

  # make sure we're posting JSON
  def process_request_headers(headers) do
    [{"content-type", "application/json"} | headers]
  end

  # API url helper - will work in any env
  defp api_url do
    endpoint_config = Application.get_env(:ex_unit_api_documentation_test_app,
                                          ExUnitApiDocumentationTestApp.Endpoint)
    host = Keyword.get(endpoint_config, :url) |> Keyword.get(:host)
    port = Keyword.get(endpoint_config, :http) |> Keyword.get(:port)

    "http://#{host}:#{port}/api"
  end

  def execute_request(method, url, request_headers, body, hn_options) do
    {:ok, resp} = super(method, url, request_headers, body, hn_options)
    ExUnitApiDocumentation.document(method, url, request_headers, body, resp)
    {:ok, resp}
  end
end
