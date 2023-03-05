defmodule RPNCalculatorInspection do
  @default_timeout 100

  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> calculator.(input) end)

    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results),
    do: Map.put(results, input, get_exit_atom(pid))

  def reliability_check(calculator, inputs) do
    reset_to = trap_exits(true)

    result =
      inputs
      |> Enum.map(fn input -> start_reliability_check(calculator, input) end)
      |> Enum.reduce(Map.new(), &await_reliability_check_result/2)
      |> tap(fn _ -> trap_exits(reset_to) end)

    trap_exits(reset_to)

    result
  end

  def correctness_check(calculator, inputs) do
    Enum.map(inputs, &Task.async(fn -> calculator.(&1) end))
    |> Enum.map(&Task.await(&1, @default_timeout))
  end

  defp trap_exits(trap), do: Process.flag(:trap_exit, trap)

  defp get_exit_atom(pid, timeout \\ @default_timeout) do
    receive do
      {:EXIT, ^pid, :normal} -> :ok
      {:EXIT, ^pid, _} -> :error
    after
      timeout -> :timeout
    end
  end
end
