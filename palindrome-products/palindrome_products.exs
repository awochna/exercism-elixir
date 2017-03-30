defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    range = Range.new(min_factor, max_factor)
    Range.new(min_factor * min_factor, max_factor * max_factor)
    |> Enum.filter(&palindrome?/1)
    |> Enum.map(&(find_factors(&1, range)))
    |> Enum.reject(&empty?/1)
    |> Enum.into(%{})
  end

  defp empty?(tuple), do: tuple_size(tuple) == 1

  defp find_factors(palindrome, range) do
    factors = Enum.filter(range, fn(factor) ->
      rem(palindrome, factor) == 0 && div(palindrome, factor) in range
    end)
    if Enum.empty?(factors) do
      {palindrome}
    else
      {palindrome, other_factors(factors, palindrome)}
    end
  end

  defp other_factors(factors, palindrome) do
    factors
    |> Enum.map(fn(factor) ->
      Enum.sort([factor, div(palindrome, factor)])
    end)
    |> Enum.uniq
  end

  defp palindrome?(number) do
    reversed = number
    |> Integer.digits
    |> Enum.reverse
    |> Integer.undigits
    reversed == number
  end
end
