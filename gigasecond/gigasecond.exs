defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {:ok, datetime} = NaiveDateTime.new(year, month, day, hours, minutes, seconds)
    giga = NaiveDateTime.add(datetime, 1_000_000_000)
    {{giga.year, giga.month, giga.day}, {giga.hour, giga.minute, giga.second}}
  end
end
