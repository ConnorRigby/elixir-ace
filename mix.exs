defmodule Ace.Mixfile do
  use Mix.Project
  @moduledoc false

  def project do
    [
      app: :ace,
      version: "0.2.0",
      elixir: "~> 1.5",
      compilers: [:elixir_make] ++ Mix.compilers,
      make_clean: ["clean"],
      make_env: make_env(),
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  defp make_env() do
    case System.get_env("ERL_EI_INCLUDE_DIR") do
      nil ->
        %{
          "ERL_EI_INCLUDE_DIR" => "#{:code.root_dir()}/usr/include",
          "ERL_EI_LIBDIR" => "#{:code.root_dir()}/usr/lib"
        }
      _ ->
        %{}
    end
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:elixir_make, "~> 0.4.0", runtime: false},
    ]
  end
end
