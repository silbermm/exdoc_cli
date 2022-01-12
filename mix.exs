defmodule ExdocCLI.MixProject do
  use Mix.Project

  def project do
    [
      app: :exdoc_cli,
      version: "0.1.3-beta",
      description: "A simple CLI for displaying built-in Elixir docs",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      escript: escript(),
      package: package(),
      dialyzer: [
        flags: ["-Wunmatched_returns", :error_handling, :race_conditions, :underspecs]
      ],
      source_url: "https://github.com/silbermm/exdoc_cli"
    ]
  end

  def escript do
    [main_module: ExdocCLI, name: "exdoc", strip_beams: [keep: ["Docs"]]]
  end

  def application do
    [
      extra_applications: [:iex, :logger]
    ]
  end

  defp deps do
    [
      {:prompt, "~> 0.7.2"},
      {:ex_doc, ">= 0.27.2", only: :dev, runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false}
    ]
  end

  defp docs do
    [
      main: "ExdocCLI",
      api_reference: false,
      extras: [
        "README.md": [filename: "readme", title: "Readme"],
        "CHANGELOG.md": [filename: "changelog", title: "Changelog"],
        COPYING: [filename: "copying", title: "License"]
      ],
      authors: ["Matt Silbernagel"]
    ]
  end

  def package() do
    [
      licenses: ["GPL-3.0-or-later"],
      files: ["lib", "mix.exs", "README.md", "CHANGELOG.md", "COPYING*"],
      maintainers: ["Matt Silbernagel"],
      links: %{:GitHub => "https://github.com/silbermm/prompt"}
    ]
  end
end
