defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({op, _, args} = ast, acc) when op in [:def, :defp] do
    {name, arity} = get_function_name_and_arity(args)

    str = String.slice(name, 0, arity)
    {ast, [str | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp get_function_name_and_arity([node | _]) do
    case node do
      {:when, _, args} -> get_function_name_and_arity(args)
      {name, _, nil} -> {Atom.to_string(name), 0}
      {name, _, params} -> {Atom.to_string(name), Enum.count(params)}
      _ -> raise "uh oh"
    end
  end

  def decode_secret_message(string) do
    to_ast(string)
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reduce("", &<>/2)
  end
end
