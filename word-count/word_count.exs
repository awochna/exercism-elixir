defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.downcase
    |> String.split([" ", "_", ",", "?", "!"])
    |> Enum.filter(&Regex.run(~r/[\w\d]+/, &1))
    |> Enum.reduce(%{}, fn(word, counts) ->
      if (Map.has_key?(counts, word)) do
        Map.update!(counts, word, &(&1 + 1))
      else
        Map.put(counts, word, 1)
      end
    end)
  end
end
