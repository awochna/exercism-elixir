defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _), do: :not_found
  def search(numbers, key) do
    lower_bound = 0
    upper_bound = tuple_size(numbers) - 1
    find(numbers, key, lower_bound, upper_bound)
  end

  defp find(numbers, key, lower, upper) do
    index = div(upper - lower, 2) + lower
    cond do
      elem(numbers, index) != key && index == lower && index == upper ->
        :not_found
      elem(numbers, index) == key ->
        {:ok, index}
      elem(numbers, index) > key ->
        find(numbers, key, lower, index)
      elem(numbers, index) < key ->
        find(numbers, key, index + 1, upper)
    end
  end
end
