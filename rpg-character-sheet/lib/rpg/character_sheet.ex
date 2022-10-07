defmodule RPG.CharacterSheet do
  @line_break "\n"

  def welcome(), do: IO.puts "Welcome! Let's fill out your character sheet together."


  def ask_name() do
    "What is your character's name?"
    |> add_line_break
    |> IO.gets
    |> String.trim
  end

  def ask_class() do
    "What is your character's class?"
    |> add_line_break
    |> IO.gets
    |> String.trim
  end

  def ask_level() do
    "What is your character's level?"
    |> add_line_break
    |> IO.gets
    |> String.trim
    |> String.to_integer
  end

  def run() do
    welcome()

    %{name: ask_name()}
    |> Map.put(:class, ask_class())
    |> Map.put(:level, ask_level())
    |> IO.inspect(label: "Your character")
  end


  defp add_line_break(line), do: line <> @line_break
end
