defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product(_, size) when size < 0, do: raise ArgumentError
  def largest_product("", _), do: raise ArgumentError
  def largest_product(number_string, size) do
    if (String.length(number_string) < size) do
      raise ArgumentError
    else
      number_string
      |> String.graphemes
      |> Enum.chunk(size, 1)
      |> Enum.map(&(multiply/1))
      |> Enum.max
    end
  end

  defp multiply([]), do: 1
  defp multiply([head | tail]) do
    String.to_integer(head) * multiply(tail)
  end
end
