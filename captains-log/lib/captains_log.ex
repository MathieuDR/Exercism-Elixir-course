defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class(), do: Enum.random(@planetary_classes)

  def random_ship_registry_number(), do: "NCC-#{Enum.random(1000..9999)}"

  def random_stardate() do
    :rand.uniform()
    |> Kernel.*(1000) # Get it between 0 and 1000
    |> Kernel.+(41000) # add starting
  end

  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate])
    |> Kernel.to_string()
  end
end
