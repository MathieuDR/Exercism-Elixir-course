defmodule LibraryFees do
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  def before_noon?(dt) do
    atom = dt
    |> NaiveDateTime.to_time()
    |> Time.compare(~T[12:00:00.000])
    |> Kernel.==(:lt)
  end

  def return_date(dt) do
    to_add = calculate_days(dt)

    dt
    |> NaiveDateTime.add(to_add, :day)
    |> NaiveDateTime.to_date()
  end

  defp calculate_days(dt) do
    case before_noon?(dt) do
      true -> 28
      false -> 29
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(dt) do
    dt
    |> NaiveDateTime.to_date()
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    return = datetime_from_string(return)

    discount = return
    |> get_discount()

    checkout
    |> datetime_from_string()
    |> return_date()
    |> days_late(return)
    |> Kernel.*(rate)
    |> Kernel.*(1 - discount)
    |> floor()
  end

  defp get_discount(dt) do
    case monday?(dt) do
      true -> 0.5
      false -> 0
    end
  end
end
