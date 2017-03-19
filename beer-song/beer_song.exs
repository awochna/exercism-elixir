defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end
  def verse(number) do
    """
    #{plural(number)} of beer on the wall, #{plural(number)} of beer.
    #{take(number)} down and pass it around, #{plural(number - 1)} of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range \\ 99..0) do
    range
    |> Enum.reverse
    |> Enum.map(&(verse(&1)))
    |> Enum.reduce(&(&1 <> "\n" <> &2))
  end

  defp plural(0), do: "no more bottles"
  defp plural(1), do: "1 bottle"
  defp plural(num), do: "#{num} bottles"

  defp take(1), do: "Take it"
  defp take(_), do: "Take one"
end
