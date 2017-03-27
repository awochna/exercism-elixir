defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    Enum.reverse(factor_out(number))
  end

  defp factor_out(number, acc \\ [], current \\ 2)
  defp factor_out(1, _, _), do: []
  defp factor_out(number, acc, current) when number == current do
    [current | acc]
  end
  defp factor_out(number, acc, current) when rem(number, current) == 0 do
    factor_out(div(number, current), [current | acc], current)
  end
  defp factor_out(number, acc, current) when current * current > number do
    [number | acc]
  end
  defp factor_out(number, acc, current) do
    factor_out(number, acc, current + 1)
  end
end
