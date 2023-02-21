defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}

  def display_distance(%RemoteControlCar{} = remote_car),
    do: "#{remote_car.distance_driven_in_meters} meters"

  def display_battery(%RemoteControlCar{battery_percentage: 0} = car), do: "Battery empty"

  def display_battery(%RemoteControlCar{} = remote_car),
    do: "Battery at #{remote_car.battery_percentage}%"

  def drive(%RemoteControlCar{battery_percentage: 0} = car), do: car

  def drive(%RemoteControlCar{} = car),
    do: %{
      car
      | battery_percentage: car.battery_percentage - 1,
        distance_driven_in_meters: car.distance_driven_in_meters + 20
    }
end
