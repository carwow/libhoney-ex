defmodule Libhoney.Mixfile do
  use Mix.Project

  def project do
    [
      app: :libhoney,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      name: "libhoney",
      source_url: "https://github.com/carwow/libhoney-ex",
      description: "A client for interacting with honeycomb.io",
      package: package()
    ]
  end

  def application do
    [
      mod: { Libhoney, [] },
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:poison, "~> 3.1"},
      {:httpoison, "~> 0.13.0"},
      {:bypass, "~> 0.8.1", only: :test},
      {:earmark, "~> 1.2", only: :dev},
      {:ex_doc, "~> 0.18.1", only: :dev}
    ]
  end

  defp package do
    [
      name: "libhoney",
      maintainers: ["Baris Balic"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/carwow/libhoney-ex"}
    ]
  end
end
