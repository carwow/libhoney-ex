defmodule Libhoney.ClientTest do
  use ExUnit.Case

  import TestHelpers, only: [json_body: 1]

  setup do
    bypass = Bypass.open
    Application.put_env(:libhoney, :api_host, "http://localhost:#{bypass.port}")

    user_agent = "libhoney-ex/#{Libhoney.version}"

    {:ok, bypass: bypass, dataset: "requests", user_agent: user_agent, content_type: "application/json"}
  end

  test "user_agent" do
    assert "libhoney-ex/#{Libhoney.version}" == Libhoney.Client.user_agent
  end

  test "create_event", %{bypass: bypass, user_agent: user_agent, content_type: content_type} do
    dataset = "requests"
    host = "http://localhost:#{bypass.port}"

    Bypass.expect bypass, fn(conn) ->
      headers = conn.req_headers |> Enum.into(%{})

      assert conn.method == "POST"
      assert conn.request_path == "/1/events/#{dataset}"
      assert headers["x-honeycomb-team"] == "special_key"
      assert headers["x-honeycomb-samplerate"] == "1"
      assert headers["content-type"] == content_type
      assert headers["user-agent"] == user_agent
      assert json_body(conn) == %{"name" => "Rick Sanchez"}

      Plug.Conn.resp(conn, 200, "")
    end

    Libhoney.Event.create("special_key", dataset, host, 1, 1512482188)
    |> Libhoney.Event.add_field("name", "Rick Sanchez")
    |> Libhoney.Client.create_event
  end

  test "create_marker", %{bypass: bypass, user_agent: user_agent, content_type: content_type} do
    dataset = "requests"
    marker = %{
      "start_time" => 1,
      "end_time" => 10,
      "message" => "Deploy #23",
      "type" => "deploy",
      "url" => "https://heroku/deploys/23"
    }

    Bypass.expect bypass, fn(conn) ->
      headers = conn.req_headers |> Enum.into(%{})

      assert conn.method == "POST"
      assert conn.request_path == "/1/markers/#{dataset}"
      assert headers["x-honeycomb-team"] == "abcde"
      assert headers["content-type"] == content_type
      assert headers["user-agent"] == user_agent
      assert is_nil(headers["x-honeycomb-samplerate"])
      assert json_body(conn) == marker

      Plug.Conn.resp(conn, 200, "")
    end

    marker
    |> Libhoney.Client.create_marker(dataset)
  end
end
