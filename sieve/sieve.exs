defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    2..limit
    |> Enum.into([])
    |> sieve
    |> Enum.reverse
  end

  defp sieve(nums, acc \\ [])
  defp sieve([], acc), do: acc
  defp sieve([num | rest], acc) do
    filtered = Enum.filter(rest, &(rem(&1, num) != 0))
    sieve(filtered, [num | acc])
  end
end
