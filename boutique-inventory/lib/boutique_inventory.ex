defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory
    |> Enum.sort_by(& &1.price)
  end

  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(&is_nil(&1.price))
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn item ->
      item
      |> Map.update!(:name, &String.replace(&1, old_word, new_word))
    end)
  end

  def increase_quantity(item, count) do
    item
    |> Map.update!(:quantity_by_size, fn enum ->
      enum
      |> Enum.into(%{}, fn {k, v} ->
        {k, v + count}
      end)
    end)
  end

  def total_quantity(item) do
    item
    |> Map.get(:quantity_by_size)
    |> Map.values()
    |> Enum.reduce(0, &+/2)
  end
end
