defmodule PigLatin do
  @vowels ["a", "e", "i", "o", "u"]
  @vowel_clusters ["xr", "yt"]
  @double_clusters ["ch", "sh", "qu", "sq", "th"]
  @triple_clusters ["thr", "sch", "squ"]

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    cond do
      String.starts_with?(word, @vowels) ->
        word <> "ay"
      String.starts_with?(word, @vowel_clusters) ->
        word <> "ay"
      String.starts_with?(word, @triple_clusters) ->
        {cluster, rest} = String.split_at(word, 3)
        rest <> cluster <> "ay"
      String.starts_with?(word, @double_clusters) ->
        {cluster, rest} = String.split_at(word, 2)
        rest <> cluster <> "ay"
      true ->
        {first, rest} = String.split_at(word, 1)
        rest <> first <> "ay"
    end
  end
end

