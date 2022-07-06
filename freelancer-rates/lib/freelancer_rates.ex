defmodule FreelancerRates do
  @daily_rate_multiplier 8.0
  @billable_days_in_month 22

  def daily_rate(hourly_rate) do
    hourly_rate * @daily_rate_multiplier
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1 - discount / 100 )
  end

  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_rate
    |> Kernel.*(@billable_days_in_month)
    |> apply_discount(discount)
    |> Float.ceil(0)
    |> trunc
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate = daily_rate(hourly_rate)
    |> apply_discount(discount)

    budget
    |> Kernel./(daily_rate)
    |> Float.floor(1)
  end
end
