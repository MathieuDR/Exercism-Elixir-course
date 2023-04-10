defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts()) :: tuple()
  @callback handle_frame(dot(), frame_number(), opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame, _) do
    case Kernel.rem(frame, 4) do
      0 -> %{dot | opacity: dot.opacity / 2}
      _ -> dot
    end
  end
end

defmodule DancingDots.Zoom do
  @behaviour DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    velocity = Keyword.get(opts, :velocity)

    if(is_integer(velocity)) do
      {:ok, opts}
    else
      {:error,
       "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame, opts) do
    velocity = Keyword.get(opts, :velocity)
    %{dot | radius: dot.radius + velocity * (frame - 1)}
  end
end
