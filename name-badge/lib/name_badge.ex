defmodule NameBadge do
  @separator " - "
  def print(id, name, department) do
    id_part = if id, do: "[#{id}]"
    department = if department == nil, do: "OWNER", else: String.upcase(department)

    [id_part, name, department]
    |> Enum.reject(&is_nil/1)
    |> Enum.join(@separator)
  end
end
