use Mix.Config

config :libhoney, api_host: "api.data.io"
config :libhoney, dataset: "ds1"
config :libhoney, write_key: "abcde"

config :libhoney, os_mock: OsMock
config :libhoney, enum_mock: EnumMock
