defmodule Libhoney.EventTest do
  use ExUnit.Case

  alias Libhoney.Event

  describe "create" do
    test "it uses all specified parameters" do
      event = Event.create("abcde", "ds1", "api.data.io", 1, 1512482188)

      assert "abcde" == event.write_key
      assert "ds1" == event.dataset
      assert "api.data.io" == event.api_host
      assert 1 == event.sample_rate
      assert 1512482188 == event.timestamp
    end

    test "it defaults the timestamp to now" do
      event = Event.create("abcde", "ds1", "api.data.io", 1)

      assert 1512482945 == event.timestamp
    end

    test "it defaults the global rate" do
      event = Event.create("abcde", "ds1", "api.data.io")

      assert 1 == event.sample_rate
      assert 1512482945 == event.timestamp
    end

    test "it defaults the api host to the global config" do
      event = Event.create("abcde", "ds1")

      assert "api.data.io" == event.api_host
    end

    test "it defaults the dataset to the global config" do
      event = Event.create("abcde")

      assert "ds1" == event.dataset
      assert 1 == event.sample_rate
      assert 1512482945 == event.timestamp
    end

    test "it defaults the write key to the global config" do
      event = Event.create()

      assert "abcde" == event.write_key
      assert "ds1" == event.dataset
      assert 1 == event.sample_rate
      assert 1512482945 == event.timestamp
    end

    test "it encodes the dataset name" do
      event = Event.create("abcde", "All requests")

      assert "All%20requests" == event.dataset
    end
  end

  describe "add_fields" do
    test "adds arbitrary fields to the event" do
      event =
        Event.create("abcde", "ds1", "api.data.io", 1, 1512482188)
        |> Event.add_field("name", "baris")
        |> Event.add_field("score", 10)

      assert "baris" == event.fields["name"]
      assert 10 == event.fields["score"]
    end
  end
end
