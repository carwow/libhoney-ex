ExUnit.start(exclude: [:skip])

defmodule TestHelpers do
  def json_body(conn) do
    {:ok, body, _} = Plug.Parsers.JSON.parse(conn, "application", "json", "", [json_decoder: Poison])
    body
  end
end

defmodule EnumMock do
  def random(1..2), do: 2
  def random(1..3), do: 1
  def random(_), do: raise "There is no EnumMock function matching this call."
end

defmodule OsMock do
  def system_time(_), do: 1512482945
end
