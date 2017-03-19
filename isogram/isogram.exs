defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) when is_binary(sentence) do
    sentence
    |> String.downcase
    |> String.graphemes
    |> Enum.filter(&(Regex.match?(~r/[^-\s]/, &1)))
    |> isogram?([])
  end
  def isogram?([], _letters), do: true
  def isogram?([letter | rest], letters) do
    if (Enum.member?(letters, letter)) do
      false
    else
      isogram?(rest, [letter | letters])
    end
  end
end
