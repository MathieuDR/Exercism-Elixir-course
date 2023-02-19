defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}

  def display_distance(remote_car) when is_struct(remote_car, RemoteControlCar), do: "#{remote_car.distance_driven_in_meters} meters"

  def display_battery(%{battery_percentage: 0} = car) when is_struct(car, RemoteControlCar), do: "Battery empty"
  def display_battery(remote_car) when is_struct(remote_car, RemoteControlCar), do: "Battery at #{remote_car.battery_percentage}%"

  def drive(%{battery_percentage: 0} = car) when is_struct(car, RemoteControlCar), do: car
  def drive(car) when is_struct(car, RemoteControlCar), do: %{car | battery_percentage: car.battery_percentage - 1, distance_driven_in_meters: car.distance_driven_in_meters + 20}

end
