defmodule UeberauthGithub.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [app: :ueberauth_github,
     version: @version,
     name: "Überauth GitHub Strategy",
     package: package,
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     source_url: "https://github.com/hassox/ueberauth_github",
     homepage_url: "https://github.com/hassox/ueberauth_github",
     description: description,
     deps: deps,
     docs: docs]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
     {:ueberauth, "~>0.1"},
     {:oauth2, "~> 0.5"},

     # docs dependencies
     {:earmark, "~>0.1", only: :dev},
     {:ex_doc, "~>0.1", only: :dev}
    ]
  end

  defp docs do
    [extras: docs_extras, main: "extra-readme"]
  end

  defp docs_extras do
    ["README.md"]
  end

  defp description do
    "An Überauth strategy for using GitHub to authenticate your users."
  end

  defp package do
    [files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Daniel Neighman"],
      licenses: ["MIT"],
      links: %{"GitHub": "https://github.com/hassox/ueberauth_github"}]
  end
end
