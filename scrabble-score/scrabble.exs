defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(""), do: 0
  def score(word) do
    word
    |> String.upcase
    |> String.graphemes
    |> count
  end

  defp count(word), do: count(word, 0)
  defp count([], score), do: score
  defp count([char | charlist], score), do: count(charlist, score + value(char))

  defp value(letter) when letter in ~w(A E I O U L N R S T), do: 1
  defp value(letter) when letter in ~w(D G), do: 2
  defp value(letter) when letter in ~w(B C M P), do: 3
  defp value(letter) when letter in ~w(F H V W Y), do: 4
  defp value(letter) when letter in ~w(K), do: 5
  defp value(letter) when letter in ~w(J X), do: 8
  defp value(letter) when letter in ~w(Q Z), do: 10
  defp value(letter), do: 0
end
