defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> String.graphemes
    |> clean
    |> trim
    |> Enum.join
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
    |> String.graphemes
    |> clean
    |> trim
    |> Enum.take(3)
    |> Enum.join
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    raw
    |> String.graphemes
    |> clean
    |> trim
    |> insert_pretties
    |> Enum.join
  end

  defp clean(graphemes) do
    if (Enum.any?(graphemes, &(Regex.match?(~r/[^\d-\(\)\.\s]/, &1)))) do
      zero_out()
    else
      Enum.filter(graphemes, &(Regex.match?(~r/\d/, &1)))
    end
  end

  defp trim(num) when length(num) == 11 and hd(num) == "1", do: tl(num)
  defp trim(num) when length(num) == 10, do: num
  defp trim(_num), do: zero_out()

  defp zero_out(), do: Enum.map(1..10, fn(_) -> 0 end)

  defp insert_pretties(graphemes) do
    graphemes
    |> List.insert_at(6, "-")
    |> List.insert_at(3, " ")
    |> List.insert_at(3, ")")
    |> List.insert_at(0, "(")
  end
end
