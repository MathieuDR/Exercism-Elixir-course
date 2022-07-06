defmodule Username do
  def sanitize(username) do
    username
    |> Enum.flat_map(fn char ->
      cond do
        filter_characters?(char) -> substitute_german(char)
        true -> []
      end
    end)

  end

  defp filter_characters?(char) do
    case char do
      ?ä -> true
      ?ö -> true
      ?ü -> true
      ?ß -> true
      ?_ -> true
      char when char >= ?a and char <= ?z -> true
      _ -> false
    end
  end

  defp substitute_german(char) do
    case char do
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      _ -> [char]
    end
  end
end
