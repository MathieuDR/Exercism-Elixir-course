defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    for t <- tops, b <- bottoms,
      b.base_color != t.base_color,
      b.price + t.price <= Keyword.get(options, :maximum_price, 100.00) do
      {t, b}
    end
  end
end
