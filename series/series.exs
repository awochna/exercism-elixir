defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_s, size) when size < 1 do
    []
  end
  def slices(s, size, acc \\ []) do
    if (String.length(s) >= size) do
      {slice, _rest} = String.split_at(s, size)
      {_lead, remaining} = String.split_at(s, 1)
      slices(remaining, size, acc ++ [slice])
    else
      acc
    end
  end
end

