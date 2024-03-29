defmodule RPNCalculator do
  def calculate!(stack, operation), do: operation.(stack)

  def calculate(stack, operation) do
    try do
      {:ok, calculate!(stack, operation)}
    rescue
      _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      {:ok, calculate!(stack, operation)}
    rescue
      x -> {:error, x.message}
    end
  end
end
