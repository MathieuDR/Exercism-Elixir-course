defmodule BirdCount do
  def today([]), do: nil
  def today([head | _]), do: head

  def increment_day_count([]), do: [1]
  def increment_day_count([today | tail]), do: [today + 1 | tail]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _]), do: true
  def has_day_without_birds?([_ | tail]), do: has_day_without_birds?(tail)

  def total([]), do: 0
  def total([head]), do: head
  def total([head, second | tail]), do: total([head + second | tail])

  def busy_days(list), do: busy_days(list, 0)

  # define a second function so we can use the compiler optimization.
  defp busy_days([], total_count), do: total_count
  defp busy_days([head | tail], total_count) when head >= 5, do: busy_days(tail, total_count + 1)
  defp busy_days([_ | tail], total_count), do: busy_days(tail, total_count)
end
