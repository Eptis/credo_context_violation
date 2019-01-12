defmodule ContextViolation.MixProject do
  use Mix.Project

  def project do
    [
      app: :credo_context_violation,
      version: "0.1.0",
      elixir: "~> 1.7",
      licenses: [],
      description: "Credo check to check function calls that violate context boundaries.",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Dennis Tel"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/eptis/credo_context_violation"},
      source_url: "https://github.com/eptis/credo_context_violation"
    ]
  end
end
