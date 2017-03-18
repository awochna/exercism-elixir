defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(string) do
    string
    |> String.graphemes
    |> count_consecutive
    |> Enum.join
  end

  @spec decode(String.t) :: String.t
  def decode(""), do: ""
  def decode(string) do
    expand_consecutive(string)
  end

  defp count_consecutive([char | charlist]) do
    count_consecutive(charlist, char, 1, [])
  end
  defp count_consecutive([], current, 1, acc), do: acc ++ [current]
  defp count_consecutive([], current, count, acc) do
    acc ++ ["#{count}#{current}"]
  end
  defp count_consecutive([char | charlist], current, count, acc) do
    cond do
      char == current ->
        count_consecutive(charlist, current, count + 1, acc)
      count == 1 ->
        count_consecutive(charlist, char, 1, acc ++ [current])
      true ->
        count_consecutive(charlist, char, 1, acc ++ ["#{count}#{current}"])
    end
  end

  defp expand_consecutive(string), do: expand_consecutive(string, "")
  defp expand_consecutive("", expanded), do: expanded
  defp expand_consecutive(string, expanded) do
    [whole, number, letter] = Regex.run(~r/^(\d+)?(.)/, string)
    {_, remaining} = String.split_at(string, String.length(whole))
    if (number == "") do
      expand_consecutive(remaining, expanded <> letter)
    else
      number = String.to_integer(number)
      expand_consecutive(remaining, expanded <> String.duplicate(letter, number))
    end
  end
end
