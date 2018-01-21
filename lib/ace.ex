defmodule Ace do
  ~s"""
  Sometime you just need a little arbitrary code execution.
  """
  require Logger
  @on_load :load_nif

  @doc false
  def load_nif do
    nif_file = '#{:code.priv_dir(:ace)}/ace_nif'
    case :erlang.load_nif(nif_file, 0) do
      :ok -> :ok
      {:error, {:reload, _}} -> :ok
      {:error, reason} -> Logger.warn "Failed to load nif: #{inspect reason}"
    end
  end

  @doc """
  Returns an integer.
  # Example

      iex(1)> code = [0x55,0x48,0x89,0xe5,0x89,0x7d,0xfc,0x48,0x89,0x75,0xf0,0xb8,0x2a,0x00,0x00,0x00,0xc9,0xc3,0x00]
      iex(2)> Ace.ace_int(code)
      42

  """
  def ace_int(_code_array), do: do_exit_no_nif()
  defp do_exit_no_nif, do: exit("nif not loaded.")
end
