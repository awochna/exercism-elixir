defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @number_days [monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5,
    saturday: 6, sunday: 7]

  @number_schedules [first: 1, second: 2, third: 3, fourth: 4]

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    {:ok, first} = Date.new(year, month, 1)
    1..Date.days_in_month(first)
    |> Enum.map(fn(day) ->
      {:ok, date} = Date.new(year, month, day)
      date
    end)
    |> filter_dates_by_weekday(weekday)
    |> select_by_schedule(schedule)
    |> format
  end

  defp filter_dates_by_weekday(set, weekday) do
    Enum.filter(set, fn(date) ->
      Date.day_of_week(date) == @number_days[weekday]
    end)
  end

  defp select_by_schedule(set, :last) do
    {:ok, date} = Enum.fetch(set, -1)
    date
  end
  defp select_by_schedule(set, :teenth) do
    Enum.find(set, &(&1.day > 12 && &1.day < 20))
  end
  defp select_by_schedule(set, schedule) do
    {:ok, date} = Enum.fetch(set, @number_schedules[schedule] - 1)
    date
  end

  defp format(date) do
    {date.year, date.month, date.day}
  end
end
