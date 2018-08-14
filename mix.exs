defmodule AlixirSms.MixProject do
  use Mix.Project

  @project_host "https://github.com/GreenNerd-Labs/alixir_sms"
  @version "0.1.0"

  def project do
    [
      app: :alixir_sms,
      version: @version,
      source_url: @project_host,
      homepage_url: @project_host,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:alixir_core, github: "GreenNerd-Labs/alixir_core", branch: "develop"},
    ]
  end
end
