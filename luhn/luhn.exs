defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.to_integer
    |> Integer.digits
    |> check
    |> Enum.reduce(&(&1 + &2))
  end

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    rem(checksum(number), 10) == 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    digit = Enum.find(0..9, fn(digit) ->
      valid?(number <> Integer.to_string(digit))
    end)
    number <> Integer.to_string(digit)
  end

  defp check(digits) do
    check(Enum.reverse(digits), [])
  end
  defp check([], doubled), do: doubled
  defp check([digit | rest], doubled) when rem(length(doubled), 2) == 1 do
    check(rest, [double(digit) | doubled])
  end
  defp check([digit | rest], doubled) do
    check(rest, [digit | doubled])
  end

  defp double(digit) when digit < 5, do: digit * 2
  defp double(digit), do: digit * 2 - 9
end
