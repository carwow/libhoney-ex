defmodule Libhoney do
  @moduledoc """
  Provides functions for interacting with the honeycomb.io API.
  """

  use Application

  @version "0.1.0"

  @doc false
  def version, do: @version

  @doc false
  def start(_type, _args) do
    Supervisor.start_link([{Libhoney.Transmission, []}], strategy: :one_for_one)
  end

  @doc """
  Sends an event to honeycomb based on the event `sample_rate`.

  Returns :ok.
      iex> Libhoney.Event.create |> Libhoney.send_event
      :ok
  """
  def send_event(%Libhoney.Event{} = event) do
    unless Libhoney.Sampling.drop?(event) do
      Libhoney.Transmission.transmit(event)
    end
  end
end
