defmodule TakeANumberDeluxe do
  use GenServer
  alias TakeANumberDeluxe.State

  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg), do: GenServer.start_link(__MODULE__, init_arg)

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine), do: GenServer.call(machine, :get_state)

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine), do: GenServer.call(machine, :queue)

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil),
    do: GenServer.call(machine, {:dequeue, priority_number})

  @spec reset_state(pid()) :: :ok
  def reset_state(machine), do: GenServer.cast(machine, :reset)

  # Server callbacks
  @impl GenServer
  def init(init_arg) do
    case State.new(
           Keyword.get(init_arg, :min_number),
           Keyword.get(init_arg, :max_number),
           Keyword.get(init_arg, :auto_shutdown_timeout, :infinity)
         ) do
      {:error, reason} -> {:stop, reason}
      {:ok, state} -> {:ok, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call(:get_state, _from, state),
    do: {:reply, state, state, state.auto_shutdown_timeout}

  def handle_call(:queue, _from, state) do
    case State.queue_new_number(state) do
      {:ok, number, state} -> {:reply, {:ok, number}, state, state.auto_shutdown_timeout}
      {:error, _} = error -> {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  def handle_call({:dequeue, priority_number}, _from, state) do
    case State.serve_next_queued_number(state, priority_number) do
      {:ok, number, state} -> {:reply, {:ok, number}, state, state.auto_shutdown_timeout}
      {:error, _} = error -> {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset, state) do
    {:ok, state} = State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)
    {:noreply, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  def handle_info(_, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
