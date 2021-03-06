defmodule AlixirSms.MixProject do
  use Mix.Project

  @project_host "https://github.com/GreenNerd-Labs/alixir_sms"
  @version "0.2.1"

  def project do
    [
      app: :alixir_sms,
      version: @version,
      source_url: @project_host,
      homepage_url: @project_host,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    "Aliyun SMS adapter."
  end

  defp deps do
    [
      {:alixir_core, "~> 0.2"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.24.2", only: :dev}
    ]
  end

  defp package do
    [
      name: :alixir_sms,
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["fahchen"],
      licenses: ["MIT"],
      links: %{"GitHub" => @project_host}
    ]
  end
end
