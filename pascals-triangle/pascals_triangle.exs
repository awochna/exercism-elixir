defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    Enum.map(1..num, &row_for/1)
  end

  defp row_for(1), do: [1]
  defp row_for(2), do: [1, 1]
  defp row_for(num) do
    previous = row_for(num - 1)
    chunks = Enum.chunk(previous, 2, 1)
    row = Enum.map(chunks, fn([first, second]) -> first + second end)
    [1] ++ row ++ [1]
  end
end
