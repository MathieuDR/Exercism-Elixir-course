defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    elem(volume_pair, 1)
  end

  def to_milliliter(volume_pair)

  def to_milliliter({:cup, volume} = _) do
    {:milliliter, volume * 240}
  end

  def to_milliliter({:milliliter, volume} = _) do
    {:milliliter, volume}
  end

  def to_milliliter({:fluid_ounce, volume} = _) do
    {:milliliter, volume * 30}
  end

  def to_milliliter({:teaspoon, volume} = _) do
    {:milliliter, volume * 5}
  end

  def to_milliliter({:tablespoon, volume} = _) do
    {:milliliter, volume * 15}
  end

  # Pattern matchhing with the head
  def from_milliliter(volume_pair, unit)

  def from_milliliter({:milliliter, volume} = _, :cup) do
    {:cup, volume / 240}
  end

  def from_milliliter({:milliliter, _} = volume_pair, :milliliter) do
    volume_pair
  end

  def from_milliliter({:milliliter, volume} = _, :fluid_ounce) do
    {:fluid_ounce, volume / 30}
  end

  def from_milliliter({:milliliter, volume} = _, :teaspoon) do
    {:teaspoon, volume / 5}
  end

  def from_milliliter({:milliliter, volume} = _, :tablespoon) do
    {:tablespoon, volume / 15}
  end


  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end
end
