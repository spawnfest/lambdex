defmodule Lambdex.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:absinthe, "~> 1.4"},
      {:base64url, "~> 0.0.1"},
      {:bbmustache, "~> 1.6"},
      {:bcrypt_elixir, "~> 1.1"},
      {:calendar, "~> 0.17.4"},
      {:comeonin, "~> 4.1"},
      {:csv, "~> 2.1"},
      {:decimal, "~> 1.6"},
      {:earmark, "~> 1.3"},
      {:ex_aws, "~> 2.1"},
      {:exjsx, "~> 4.0"},
      {:floki, "~> 0.20.4"},
      {:gpb, "~> 4.4"},
      {:hackney, "~> 1.14"},
      {:httpoison, "~> 1.4"},
      {:httpotion, "~> 3.1"},
      {:inflex, "~> 1.10"},
      {:jason, "~> 1.1"},
      {:neotoma, "~> 1.7"},
      {:redix, "~> 0.9.0"},
      {:sweet_xml, "~> 0.6.5"},
      {:uuid, "~> 1.1"},
      {:yamerl, "~> 0.7.0"},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run apps/lambdex_server/priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"]
    ]
  end
end
