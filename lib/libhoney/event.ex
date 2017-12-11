defmodule Libhoney.Event do
  @moduledoc """
  Provides functions for manipulating `Event` structs.
  """

  @os_module Application.get_env(:libhoney, :os_mock) || :os

  @default_api_host Application.get_env(:libhoney, :api_host) || "https://api.honeycomb.io"
  @default_sample_rate Application.get_env(:libhoney, :sample_rate) || 1

  @enforce_keys [:write_key, :dataset, :api_host, :sample_rate, :timestamp]
  defstruct @enforce_keys ++ [fields: %{}]

  @doc """
  Returns an `Event` struct.  All parameters are optional and will be defaulted to those set
  in the mix config.
      iex> Libhoney.Event.create("apples", "pears", "http://api.honeycomb.io", 1, 1512482945)
      %Libhoney.Event{api_host: "http://api.honeycomb.io", dataset: "pears",
        fields: %{}, sample_rate: 1, timestamp: 1512482945, write_key: "apples"}
  """
  def create(write_key, dataset, api_host, sample_rate, timestamp) do
    %Libhoney.Event{
      write_key: write_key,
      dataset: URI.encode(dataset),
      api_host: api_host,
      sample_rate: sample_rate,
      timestamp: timestamp
    }
  end
  def create(write_key, dataset, api_host, sample_rate) do
    create(write_key, dataset, api_host, sample_rate, @os_module.system_time(:seconds))
  end
  def create(write_key, dataset, api_host) do
    create(write_key, dataset, api_host, @default_sample_rate,  @os_module.system_time(:seconds))
  end
  def create(write_key, dataset) do
    create(write_key, dataset, @default_api_host, @default_sample_rate,  @os_module.system_time(:seconds))
  end
  def create(write_key) do
    dataset = Application.get_env(:libhoney, :dataset)
    create(write_key, dataset, @default_api_host, @default_sample_rate,  @os_module.system_time(:seconds))
  end
  def create do
    dataset = Application.get_env(:libhoney, :dataset)
    write_key = Application.get_env(:libhoney, :write_key)
    create(write_key, dataset, @default_api_host, @default_sample_rate,  @os_module.system_time(:seconds))
  end

  @doc """
  Returns an `Event` struct with a key/value pair added to the fields.
      iex> evt = Libhoney.Event.create("apples", "pears", "http://api.honeycomb.io", 1, 1512482945)
      iex> evt |> Libhoney.Event.add_field("name", "Rick Anchez")
      %Libhoney.Event{api_host: "http://api.honeycomb.io", dataset: "pears",
        fields: %{"name" => "Rick Sanchez"}, sample_rate: 1, timestamp: 1512482945, write_key: "apples"}
  """
  def add_field(event, key, value) do
    new_fields =
      event.fields
      |> Map.put(to_string(key), value)

    %{ event | fields: new_fields}
  end
end
