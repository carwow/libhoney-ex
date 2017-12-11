# libhoney

A library for interacting with the [honeycomb.io](https://honeycomb.io/docs/reference/api/) API.  Built against the
[SDK](https://honeycomb.io/docs/reference/sdk-spec/) requirements posted by honeycomb.  Currently this library meets
the minimum requirements specification.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `libhoney` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:libhoney, "~> 0.1.0"}
  ]
end
```


## Usage

### Events

#### Constructing an event

```elixir
alias Libhoney.Event

event = Event.create("write_key", "requests", "https://api.honeycomb.io")
event =
  event
  |> Event.add_field("name", "Rick Sanchez")
  |> Event.add_field("earth_dimension", 137)
```


#### Creating an event

```elixir

alias Libhoney.Event

Event.create("write_key", "requests", "https://api.honeycomb.io")
|> Libhoney.send_event

```


### Markers

Markers are not part of the minimum spec, and haven't been added yet.

### Configuration

For now libhoney allows you to configure any global settings via application config.

In your `config.exs` or `config/[env].exs`:

```elixir
config :libhoney, api_host: "https://api.honeycomb.io"
config :libhoney, dataset: "requests"
config :libhoney, write_key: "lemons"
config :libhoney, sample_rate: 1
```

Both `api_host` and `sample_rate` will use the required defaults specified by honeycomb.io, however if `dataset` or
`write_key` are not provided, attempts to contact the API will result in an error.

