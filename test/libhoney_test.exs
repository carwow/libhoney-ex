defmodule LibhoneyTest do
  use ExUnit.Case, async: :false

  test "start" do
  end

  test "send_event" do
    refute is_nil(Process.whereis(Libhoney.Transmission))
    Application.stop(:libhoney)
    Process.register(self(), Libhoney.Transmission)

    event =
      Libhoney.Event.create("abcde", "ds1", "api.data.io", 1, 1512482188)
      |> Libhoney.Event.add_field("name", "baris")
      |> Libhoney.Event.add_field("score", 10)

    Libhoney.send_event(event)
    assert_received(event)

    Application.start(:libhoney)
  end
end
