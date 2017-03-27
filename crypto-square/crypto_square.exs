defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(str) do
    str = str
    |> String.downcase
    |> String.graphemes
    |> Enum.filter(&(Regex.match?(~r/[1-9a-z]/, &1)))
    num_rows = rows(length(str))
    str
    |> Enum.chunk(num_rows, num_rows, List.duplicate([" "], num_rows))
    |> rotate_matrix
    |> Enum.intersperse(" ")
    |> List.flatten
    |> List.to_string
    |> String.replace("  ", " ")
    |> String.trim
  end

  defp rows(size) do
    root = :math.sqrt(size)
    if (round(root) != root) do
      round(root) + 1
    else
      round(root)
    end
  end

  defp rotate_matrix(rows, columns \\ []) do
    if (Enum.all?(rows, &Enum.empty?/1)) do
      Enum.reverse(columns)
    else
      columns = [Enum.map(rows, fn([h | _t]) -> h end)] ++ columns
      rows = Enum.map(rows, fn([_h | t]) -> t end)
      rotate_matrix(rows, columns)
    end
  end
end
