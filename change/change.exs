defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(_, []), do: :error
  def generate(amount, values) do
    change = values
    |> Enum.sort
    |> Enum.reverse
    |> divide_into(amount)
    if (Enum.empty?(change)) do
      :error
    else
      {:ok, change}
    end
  end

  defp divide_into(coins, amount, change \\ %{})
  defp divide_into([], 0, change), do: change
  defp divide_into([], _amount, _change), do: %{}
  defp divide_into([coin | [sm | []]], amt, chg) when rem(amt, coin) < sm do
    divide_into([sm | []], amt, Map.put(chg, coin, 0))
  end
  defp divide_into([coin | rest], amount, change) do
    num = div(amount, coin)
    change = Map.put(change, coin, num)
    divide_into(rest, amount - (num * coin), change)
  end
end
