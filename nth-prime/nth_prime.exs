defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise ArgumentError
  def nth(1), do: 2
  def nth(count) do
    calculate(count)
  end

  defp calculate(count, primes \\ [2], number \\ 3)
  defp calculate(count, primes, _) when length(primes) == count, do: hd(primes)
  defp calculate(count, primes, number) do
    if (is_prime?(number)) do
      calculate(count, [number | primes], number + 1)
    else
      calculate(count, primes, number + 1)
    end
  end

  defp is_prime?(candidate) do
    set = Range.new(2, candidate - 1)
    !Enum.any?(set, fn(num) ->
      rem(candidate, num) == 0
    end)
  end
end
