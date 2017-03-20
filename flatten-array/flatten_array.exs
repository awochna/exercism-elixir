defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list, tail \\ [])
  def flatten([], tail), do: tail
  def flatten([h | t], tail) when h == nil do
    flatten(t, tail)
  end
  def flatten([h | t], tail) when is_list(h) do
    flatten(h, flatten(t, tail))
  end
  def flatten([h | t], tail) do
    [h | flatten(t, tail)]
  end
end
