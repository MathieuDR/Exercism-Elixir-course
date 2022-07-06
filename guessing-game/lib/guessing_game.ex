defmodule GuessingGame do

  def compare(secret_number, guess \\ :no_guess)

  def compare(_, :no_guess = _) do
    "Make a guess"
  end

  def compare(secret_number, guess) when abs(secret_number - guess) == 1 do
    "So close"
  end

  def compare(secret_number, guess) when secret_number > guess do
    "Too low"
  end

  def compare(secret_number, guess) when secret_number < guess do
    "Too high"
  end

  def compare(secret_number, guess) when secret_number === guess do
    "Correct"
  end
end
