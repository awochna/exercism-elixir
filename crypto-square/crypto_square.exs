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
    |> Enum.filter(&(Regex.match?(~r/[a-z]/, &1)))
    num_rows = rows(length(str))
    str
    |> Enum.chunk(num_rows, num_rows, List.duplicate([" "], num_rows))
    |> rotate_matrix
    |> Enum.intersperse(" ")
    |> List.flatten
    |> List.to_string
  end

  defp rows(size) do
    round(:math.sqrt(size)) - 1
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
