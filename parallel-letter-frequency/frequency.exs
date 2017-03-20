defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Enum.join
    |> String.downcase
    |> String.graphemes
    |> Enum.chunk(workers, workers, [])
    |> Enum.map(fn(text) ->
      Task.async(__MODULE__, :count, [text])
    end)
    |> Enum.map(&(Task.await(&1)))
    |> Enum.reduce(%{}, fn(result_set, acc) ->
      Map.merge(acc, result_set, fn(_k, v1, v2) -> v1 + v2 end)
    end)
  end

  def count(text, acc \\ %{})
  def count([], acc), do: acc
  def count([letter | text], acc) do
    if (Regex.match?(~r/[^\s?\-!\.,1-9]/, letter)) do
      count(text, Map.update(acc, letter, 1, &(&1 + 1)))
    else
      count(text, acc)
    end
  end
end
