defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end


  def decode_secret_message_part({_, _, [{:when, _, [a | _]} | _ ]} = ast, acc), do: {ast, accumulate(a, acc)}
  def decode_secret_message_part({operation, _, [a | _ ]} = ast, acc) do
    case operation do
      :def -> {ast, accumulate(a, acc)}
      :defp -> {ast, accumulate(a, acc)}
      _ -> {ast, acc}
    end
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp accumulate(node, acc) do
    [name, params] = decode_function(node)
    append_string(name, acc, params)
  end

  defp decode_function({name, _, params}), do: [name, params]

  defp append_string(_, acc, nil), do: ["" | acc]

  defp append_string(atom, acc, params) do
    str = Atom.to_string(atom)
    |> String.slice(0, Enum.count(params))

    [str | acc]
  end

  def decode_secret_message(string) do
    to_ast(string)
    |> Macro.prewalk([] , &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reduce("", &<>/2)

  end
end
