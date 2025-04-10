defmodule RemixiconElixir.MixProject do
  use Mix.Project

  @version "0.1.1"
  @source_url "https://github.com/formrausch/remixicons_elixir"

  def project do
    [
      app: :remixicon,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Remix Icon",
      source_url: @source_url,
      description: "Phoenix components for Remix Icon",
      preferred_cli_env: [
        docs: :docs,
        "hex.publish": :docs
      ],
      docs: docs(),
      package: package(),
      xref: [exclude: [:httpc, :public_key]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :inets, :ssl]
    ]
  end

  defp deps do
    [
      {:phoenix_live_view, "~> 1.0"},
      {:castore, "~> 1.0"},
      {:ex_doc, "~> 0.27", only: :docs, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      extras: ["README.md"]
    ]
  end
end
