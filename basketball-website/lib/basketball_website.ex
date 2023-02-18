defmodule BasketballWebsite do
  def extract_from_path(data, path), do: extract(data, split_path(path))

  defp extract(nil = _, _), do: nil

  defp extract(data, []), do: data # end of list

  defp extract(data, [next | tail] = _) when is_map(data), do: extract(data[next], tail)

  defp extract(_, _), do: nil # data is not a map

  def get_in_path(data, path), do: Kernel.get_in(data, split_path(path))

  defp split_path(path), do: String.split(path, ".")
end
