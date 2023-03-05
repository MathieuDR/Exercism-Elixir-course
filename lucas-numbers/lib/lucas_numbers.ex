defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """

  @first 2
  @second 1

  def generate(x) when is_integer(x) and x >= 1 do
    Stream.iterate({@first, @second}, fn {first, second} ->
      {second, first + second}
    end)
    |> Enum.take(x)
    |> Enum.map(fn {first, _} -> first end)
  end

  def generate(_), do: raise(ArgumentError, "count must be specified as an integer >= 1")
end
