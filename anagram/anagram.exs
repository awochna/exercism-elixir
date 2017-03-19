defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    Enum.filter(candidates, fn(candidate) ->
      matches?(normalize(base), normalize(candidate))
    end)
  end

  defp matches?(base, candidate) when base == candidate, do: false
  defp matches?(base, candidate) when length(base) == length(candidate) do
    Enum.sort(base) == Enum.sort(candidate)
  end
  defp matches?(_base, _candidate), do: false

  defp normalize(string) do
    string
    |> String.downcase
    |> String.graphemes
  end
end
