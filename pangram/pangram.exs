defmodule Pangram do
  @letters ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    sentence
    |> String.downcase
    |> String.graphemes
    |> pangram?(@letters)
  end
  def pangram?(charlist, []), do: true
  def pangram?(charlist, [letter | rest]) do
    Enum.member?(charlist, letter) && pangram?(charlist, rest)
  end
end
