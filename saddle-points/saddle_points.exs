defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn(row) ->
      row
      |> String.split
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows
    |> rotate_matrix
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    mrows = rows(str)
    mcols = columns(str)
    Enum.reduce(mrows, [], fn(row, acc) ->
      col_index = Enum.find_index(mrows, &(&1 == row))
      {row_index, num} = greatest_of(row)
      column = Enum.at(mcols, row_index)
      if (least_in_col(column, num)) do
        [{col_index, row_index} | acc]
      else
        acc
      end
    end)
    |> Enum.reverse
  end

  defp greatest_of(row, greatest \\ nil, index \\ nil)
  defp greatest_of([head | tail], nil, nil) do
    greatest_of(tail, {0, head}, 0)
  end
  defp greatest_of([], greatest, _), do: greatest
  defp greatest_of([head | tail], greatest, index) do
    if (head > elem(greatest, 1)) do
      greatest_of(tail, {index + 1, head}, index + 1)
    else
      greatest_of(tail, greatest, index + 1)
    end
  end

  defp least_in_col(column, num) do
    Enum.min(column) == num
  end

  defp rotate_matrix(rows, columns \\ []) do
    if (Enum.any?(rows, &Enum.empty?/1)) do
      Enum.reverse(columns)
    else
      columns = [Enum.map(rows, fn([h | _t]) -> h end)] ++ columns
      rows = Enum.map(rows, fn([_h | t]) -> t end)
      rotate_matrix(rows, columns)
    end
  end
end
