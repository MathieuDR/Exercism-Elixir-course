defmodule Acronym do
  @moduledoc """
  The Acronym module to create dumb abbreviations
  """

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.scan(~r/(?:^|\s|\s_|-)([a-zA-Z])/, string, capture: :all)
    |> Enum.map(&String.upcase(Enum.at(&1, 1)))
    |> Enum.join()
  end
end
