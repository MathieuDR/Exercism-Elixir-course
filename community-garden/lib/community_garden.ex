# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []), do: Agent.start_link(fn -> {1, []} end, opts)

  def list_registrations(pid) do
    {_, registrations} = get_state(pid)

    registrations
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {next_id, registrations} = _ ->
      new_state = {next_id + 1, [create_plot(next_id, register_to) | registrations]}
      {new_state, new_state}
    end)
    |> elem(1)
    |> Enum.at(0)
  end

  def release(pid, plot_id) do
    Agent.cast(pid, fn {next_id, registrations} ->
      new_registrations = Enum.reject(registrations, fn plot -> plot.plot_id == plot_id end)
      {next_id, new_registrations}
    end)

    :ok
  end

  def get_registration(pid, plot_id) do
    {_, plots} = get_state(pid)

    Enum.find(plots, {:not_found, "plot is unregistered"}, &(&1.plot_id == plot_id))
  end

  defp get_state(pid), do: Agent.get(pid, & &1)
  defp create_plot(id, to), do: %Plot{plot_id: id, registered_to: to}
end
