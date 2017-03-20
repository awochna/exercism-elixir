defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.map(fn({k, v}) -> expand(v, k) end)
    |> Enum.reduce(&Map.merge/2)
  end

  def expand([], _value), do: %{}
  def expand([word | words], value) do
    Map.merge(%{String.downcase(word) => value}, expand(words, value))
  end
end
