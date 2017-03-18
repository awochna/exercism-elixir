defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate([], _fun) do
    []
  end
  def accumulate([h | t], fun) do
    accumulate(t, fun, [apply(fun, [h])])
  end
  def accumulate([], _fun, acc) do
    Enum.reverse(acc)
  end
  def accumulate([h | t], fun, acc) do
    accumulate(t, fun, [apply(fun, [h]) | acc])
  end
end
